//
//  MovieListInteractor.swift
//  Movies
//
//  Created by Murtuza Saify on 2/9/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class MovieListInteractor: MovieListBusinessLogic {

    var datastore: MovieListDatastore?

    // Worker to fetch data from remote server
    var remoteMovieListWorker: FetchMovieListUseCase?

    // Worker to fetch and save data to local cache
    var offlineMovieListWorker: (FetchMovieListUseCase & CacheMovieListUseCase)?

    // Worker to search videos based on serach text
    var searchMovieWorker: SearchMovieListUseCase?

    // Delegate to output the results to interactor
    weak var output: MovieListBusinessLogicOutput?

    // variable to hold current fetch criteria selected amongst popular, top rated, upcoming.
    private var currentFetchCriteria: MovieFetchCriteria = .popular

    // Array to hold criterias for which fetch is in progress.
    private var fetchInProgressCriterias: [MovieFetchCriteria] = []

    // variable to hold current search term
    private var currentSearchTerm: String?

    // Method to get movies based on provided criteria, retruns the data available in datastore for the given criteria else fetches first page for that criteria
    func getMoviesFor(criteria: MovieFetchCriteria) {
        currentFetchCriteria = criteria
        if datastore?.movieCollectionStore?[criteria] != nil {
            delegateResultsForCurrentSelectedCriteriaAndSearchTermIfApplicable()
        } else {
            fetchMoviesFor(page: 1)
        }
    }

    // Method supposed to be called as the list is scrolled to end to fetch the next page data
    func loadMoreMovies() {
        guard !fetchInProgressCriterias.contains(currentFetchCriteria),
              isReachable(),
              !isSearchInProgress(),
              let existingCollection = datastore?.movieCollectionStore?[currentFetchCriteria],
              !existingCollection.isLastPage() else {
            return
        }
        let currentPage = datastore?.movieCollectionStore?[currentFetchCriteria]?.page ?? 0
        fetchMoviesFor(page: currentPage + 1)
    }

    // Method supposed to be called as the search term changes to display result based on new search term
    func searchMoviesMatching(searchTerm: String?) {
        defer {
            delegateResultsForCurrentSelectedCriteriaAndSearchTermIfApplicable()
        }
        guard let searchTerm = searchTerm,
              !searchTerm.isEmpty else {
            currentSearchTerm = nil
            return
        }
        currentSearchTerm = searchTerm
    }
}

extension MovieListInteractor {

    // Method to output data to presenter based on selected criteria and search term (if exists)
    private func delegateResultsForCurrentSelectedCriteriaAndSearchTermIfApplicable() {
        var movies = datastore?.movieCollectionStore?[currentFetchCriteria]?.movies ?? []
        if let searchTerm = currentSearchTerm {
            movies = searchMovieWorker?.searchMovieFor(searchTerm: searchTerm, from: movies) ?? []
        }
        output?.present(movies: movies)
    }

    // Method to fetch data for provided page number using either remoteMovieListWorker or offlineMovieListWorker
    private func fetchMoviesFor(page: Int) {
        let criteria = currentFetchCriteria
        fetchInProgressCriterias.append(criteria)
        let listFetchWorker = isReachable() ? remoteMovieListWorker : offlineMovieListWorker
        listFetchWorker?.fetchMovies(criteria: criteria,
                                     page: page,
                                     completion: { [weak self] (collection, error) in
                                        if var collection = collection {
                                            if let existingCollection = self?.datastore?.movieCollectionStore?[criteria] {
                                                collection.mergeWith(previousCollection: existingCollection)
                                            }
                                            self?.datastore?.movieCollectionStore?[criteria] = collection
                                            self?.delegateResultsForCurrentSelectedCriteriaAndSearchTermIfApplicable()
                                            self?.offlineMovieListWorker?.cache(movieCollection: collection, criteria: criteria)
                                         } else if let error = error {
                                            self?.output?.present(error: error)
                                         }
                                         self?.fetchInProgressCriterias.removeAll(where: { $0 == criteria })
                                      })
    }

    // Method to check reachability
    private func isReachable() -> Bool {
        do {
            let isReachable = try Reachability().connection != .unavailable
            return isReachable
        } catch {
            return false
        }
    }

    // Method to check if any search data is currently being displayed
    private func isSearchInProgress() -> Bool {
        return currentSearchTerm != nil
    }
}
