//
//  Movie.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int?
    var title: String?
    var rating: Double?
    var overview: String?
    var releaseDate: Date?
    var imagePath: String?
    var popularity: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case rating = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
        case imagePath = "poster_path"
        case popularity = "popularity"
    }
}
