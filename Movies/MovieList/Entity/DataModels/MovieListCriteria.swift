//
//  MovieFetchCriteria.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

enum MovieFetchCriteria: String {
    case popular
    case topRated = "top_rated"
    case upcoming

    func displayName() -> String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
