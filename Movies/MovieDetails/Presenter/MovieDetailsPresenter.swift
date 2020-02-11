//
//  MovieDetailsPresenter.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation

class MovieDetailsPresenter: MovieDetailsPresentationLogic {

    var interactor: MovieDetailsBusinessLogic?
    weak var displayer: MovieDetailsDisplayLogic?
    var router: MovieDetailsWireframe?

    func onViewDidLoad() {
        interactor?.fetchMovieDetails()
    }
}

extension MovieDetailsPresenter: MovieDetailsBusinessLogicOutput {

    func didFetchMovieDetails(movie: Movie) {
        var sections: [MovieDetailsViewModel.Section] = []
        let overviewCellModel = MovieDetailsOverviewCellModel(movie: movie)
        let overviewSection = MovieDetailsViewModel.Section.overview(model: overviewCellModel)
        sections.append(overviewSection)

        let productionCompaniesCellModels: [MovieProductionCompanyInfoCellModel] = movie.productionCompanies?.compactMap { MovieProductionCompanyInfoCellModel(movieProductionCompany: $0) } ?? []
        if productionCompaniesCellModels.count > 0 {
            sections.append(MovieDetailsViewModel.Section.productionHouses(title: "Production Companies", models: productionCompaniesCellModels))
        }
        displayer?.display(viewModel: MovieDetailsViewModel(sections: sections, viewTitle: movie.title))
    }
    
    func didFailWith(error: Error) {

    }
}
