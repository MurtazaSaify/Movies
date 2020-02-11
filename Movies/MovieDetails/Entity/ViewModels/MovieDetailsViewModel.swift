//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel {

    enum Section {
        case overview(model: MovieDetailsOverviewCellModel)
        case productionHouses(title: String, models: [MovieProductionCompanyInfoCellModel])
    }

    var sections: [Section]
    var viewTitle: String?
}
