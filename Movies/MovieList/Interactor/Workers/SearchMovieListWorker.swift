//
//  SearchMovieListWorker.swift
//  Movies
//
//  Created by Murtuza Saify on 2/9/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class SearchMovieListWorker: SearchMovieListUseCase {

    func searchMovieFor(searchTerm: String, from movies: [Movie]) -> [Movie] {
        return movies.filter { $0.title?.contains(searchTerm) == true }
    }
}
