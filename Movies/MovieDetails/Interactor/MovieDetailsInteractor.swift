//
//  MovieDetailsInteractor.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class MovieDetailsInteractor: MovieDetailsBusinessLogic {

    var datastore: MovieDetailsDatastore?
    var output: MovieDetailsBusinessLogicOutput?
    private var apiManager: MovieAPIManager?

    init(apiManager: MovieAPIManager) {
        self.apiManager = apiManager
    }
    
    func fetchMovieDetails() {
        guard let movieId = datastore?.movie?.id else {
            return
        }
        apiManager?.fetchMovieDetailsFor(movieId: movieId,
                                         completion: { [weak self] (movie, error) in
                                            if let movie = movie {
                                                self?.datastore?.movie = movie
                                                self?.output?.didFetchMovieDetails(movie: movie)
                                            } else if let error = error {
                                                self?.output?.didFailWith(error: error)
                                            }
                                        })
    }
}
