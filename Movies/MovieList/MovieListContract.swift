//
//  MovieListContract.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

// To be confirmed by ViewController to handle display logics
protocol MovieListDisplayLogic {
    var presenter: MovieListPresentationLogic? { get set }
    func display(cellModels: [MovieListCellModel])
    func display(listingCriterias: MovieListCriteriaSegmentViewModel)
}

// To be confirmed by Presenter to handle presentation logics
protocol MovieListPresentationLogic {
    var displayer: MovieListDisplayLogic? { get set }
    var router: MovieListWireframe? { get set }
    var interactor: MovieListBusinessLogic? { get set }

    func onViewDidLoad()
    func onSelect(criteria: MovieFetchCriteria)
    func loadMoreDataOnReachingListEnd()
    func onSearchTermChangeTo(searchTerm: String?)
}

// Datastore to hold fetched data for different criterias (popular, top rated, upcoming)
protocol MovieListDatastore {
    var movieCollectionStore: [MovieFetchCriteria : MovieCollection]? { get set }
}

// To be confirmed by Interactor
protocol MovieListBusinessLogic {
    var datastore: MovieListDatastore? { get set }
    var remoteMovieListWorker: FetchMovieListUseCase? { get set }
    var offlineMovieListWorker: (FetchMovieListUseCase & CacheMovieListUseCase)? { get set }
    var searchMovieWorker: SearchMovieListUseCase? { get set }
    var output: MovieListBusinessLogicOutput? { get set }

    func getMoviesFor(criteria: MovieFetchCriteria)
    func loadMoreMovies()
    func searchMoviesMatching(searchTerm: String?)
}

// Interactor's delegate to output fetch results. To be confirmed by presenter ideally
protocol MovieListBusinessLogicOutput: class {
    func present(movies: [Movie])
    func present(error: Error)
}

// To be confirmed by Router
protocol MovieListWireframe {
    var viewController: UIViewController? { get set }
}

// Use case to fetch movies based on criteria
protocol FetchMovieListUseCase {
    func fetchMovies(criteria: MovieFetchCriteria, page: Int, completion: @escaping ((_ collection: MovieCollection?, _ error: Error?) -> ()))
}

// Use case to cache fetched data to be used in offline mode
protocol CacheMovieListUseCase {
    func cache(movieCollection: MovieCollection, criteria: MovieFetchCriteria)
}

// Use case to filter moview results based on search term
protocol SearchMovieListUseCase {
    func searchMovieFor(searchTerm: String, from movies: [Movie]) -> [Movie]
}


