//
//  MovieListInteractor.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

// Worker to fetch data from remote using movie api manager
class FetchRemoteMovieListWorker: FetchMovieListUseCase {

    var apiManager: MovieAPIManager?

    init(apiManager: MovieAPIManager) {
        self.apiManager = apiManager
    }

    func fetchMovies(criteria: MovieFetchCriteria, page: Int, completion: @escaping ((MovieCollection?, Error?) -> ())) {
        apiManager?.fetchMovies(criteria: criteria, page: page, completion: { (collection, error) in
            completion(collection, error)
        })
    }
}
