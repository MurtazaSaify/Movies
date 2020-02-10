//
//  DefaultMovieListDatastore.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class DefaultMovieListDatastore: MovieListDatastore {

    var movieCollectionStore: [MovieFetchCriteria : MovieCollection]? = [:]
}
