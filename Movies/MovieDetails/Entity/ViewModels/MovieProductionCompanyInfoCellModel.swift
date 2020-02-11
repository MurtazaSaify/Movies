//
//  MovieProductionCompanyInfoCellModel.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

struct MovieProductionCompanyInfoCellModel {
    var imagePath: String?
    var title: String?

    init(movieProductionCompany: MovieProductionCompany) {
        self.imagePath = movieProductionCompany.imagePath
        self.title = movieProductionCompany.name
    }
}
