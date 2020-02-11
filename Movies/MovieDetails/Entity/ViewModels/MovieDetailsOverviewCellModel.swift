//
//  MovieDetailsOverviewCellModel.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsOverviewCellModel {
    var title: String?
    var overview: String?
    var ratingViewModel: MovieRatingViewModel?
    var genreText: String?
    var posterImagePath: String?

    init(movie: Movie) {
        self.title = movie.title
        self.posterImagePath = movie.imagePath
        if let rating = movie.rating {
            ratingViewModel = MovieRatingViewModel(rating: rating)
        }
        self.overview = movie.overview
        self.genreText = movie.genres?.compactMap { $0.name }.joined(separator: ", ")
    }
}
