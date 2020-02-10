//
//  MovieCollection.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

struct MovieCollection: Codable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }

    mutating func mergeWith(previousCollection: MovieCollection) {
        let mergedMovies = (previousCollection.movies ?? []) + (movies ?? [])
        self.movies = mergedMovies
    }
}

extension MovieCollection {

    func isLastPage() -> Bool {
        guard page != nil else {
            return false
        }
        return page == totalPages
    }
}
