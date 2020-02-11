//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

// MoviewListCell view model
struct MovieListCellModel {
    var movieId: Int?
    var title: String?
    var imageFilePath: String?
    var ratingViewModel: MovieRatingViewModel?
    var movieDescription: String?

    init(movie: Movie) {
        self.movieId = movie.id
        self.title = movie.title
        self.imageFilePath = movie.imagePath
        if let rating = movie.rating {
            self.ratingViewModel = MovieRatingViewModel(rating: rating)
        }
        self.movieDescription = movie.overview
    }
}

struct MovieRatingViewModel {
    var ratingText: String?
    var ratingTint: UIColor?

    init(rating: Double) {
        ratingText = "\(rating)"
        if rating < 4.0 {
            ratingTint = .red
        } else if rating < 8.0 {
            ratingTint = .darkYellow
        } else {
            ratingTint = .darkGreen
        }
    }
}
