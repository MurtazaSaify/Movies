//
//  MovieListPresenter.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class MovieListPresenter: MovieListPresentationLogic {

    var interactor: MovieListBusinessLogic?
    var displayer: MovieListDisplayLogic?
    var router: MovieListWireframe?

    func onViewDidLoad() {

        displayer?.display(listingCriterias: MovieListCriteriaSegmentViewModel(criterias: [.popular, .topRated, .upcoming]))
    }

    func onSelect(criteria: MovieFetchCriteria) {

        interactor?.getMoviesFor(criteria: criteria)
    }

    func loadMoreDataOnReachingListEnd() {

        interactor?.loadMoreMovies()
    }

    func onSearchTermChangeTo(searchTerm: String?) {

        interactor?.searchMoviesMatching(searchTerm: searchTerm)
    }

    func onSelectMovieWith(id: Int) {
        guard let movie = interactor?.movieFor(movieId: id) else {
            return
        }
        router?.routeToMovieDetails(movie: movie)
    }
}

extension MovieListPresenter: MovieListBusinessLogicOutput {

    func present(movies: [Movie]) {
        let cellModels = movies.compactMap { MovieListCellModel(movie: $0) }
        displayer?.display(cellModels: cellModels)
    }
    
    func present(error: Error) {
        
    }
}
