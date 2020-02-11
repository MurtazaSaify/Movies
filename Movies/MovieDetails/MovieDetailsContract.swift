//
//  MovieDetailsContract.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailsDisplayLogic: class {
    var presenter: MovieDetailsPresentationLogic? { get set }
    func display(viewModel: MovieDetailsViewModel)
}

protocol MovieDetailsPresentationLogic {
    var interactor: MovieDetailsBusinessLogic? { get set }
    var displayer: MovieDetailsDisplayLogic? { get set }
    var router: MovieDetailsWireframe? { get set }
    func onViewDidLoad()
}

protocol MovieDetailsBusinessLogic {
    var datastore: MovieDetailsDatastore? { get set }
    var output: MovieDetailsBusinessLogicOutput? { get set }
    func fetchMovieDetails()
}

protocol MovieDetailsBusinessLogicOutput {
    func didFetchMovieDetails(movie: Movie)
    func didFailWith(error: Error)
}

protocol MovieDetailsWireframe {
    var viewController: UIViewController? { get set }
}

protocol MovieDetailsDatastore {
    var movie: Movie? { get set }
}
