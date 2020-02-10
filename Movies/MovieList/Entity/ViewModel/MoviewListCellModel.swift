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
    var title: String?
    var imageFilePath: String?
    var ratingText: String?
    var ratingBackgroundTint: UIColor?
    var movieDescription: String?

    init(movie: Movie) {
        self.title = movie.title
        self.imageFilePath = movie.imagePath
        self.ratingText = "\(movie.rating ?? 0)"
        if let rating = movie.rating {
            if rating < 4.0 {
                ratingBackgroundTint = .red
            } else if rating < 8.0 {
                ratingBackgroundTint = .darkYellow
            } else {
                ratingBackgroundTint = .darkGreen
            }
        }
        self.movieDescription = movie.overview
    }
}
