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
    var productionCompanies: [MovieProductionCompany]?
    var genres: [MovieGenre]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating = "vote_average"
        case overview
        case releaseDate = "release_date"
        case imagePath = "poster_path"
        case popularity
        case productionCompanies = "production_companies"
        case genres
    }
}

struct MovieProductionCompany: Codable {
    var id: Int?
    var imagePath: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagePath = "logo_path"
    }
}

struct MovieGenre: Codable {
    var id: Int?
    var name: String?
}
