//
//  MovieDetailsRouter.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsRouter: MovieDetailsWireframe {

    var viewController: UIViewController?

    static func configureModule(with movie: Movie) -> MovieDetailsViewController? {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController

        var presenter: MovieDetailsPresentationLogic & MovieDetailsBusinessLogicOutput = MovieDetailsPresenter()
        var interactor: MovieDetailsBusinessLogic = MovieDetailsInteractor(apiManager: DefaultMovieAPIManager())
        var datastore: MovieDetailsDatastore = DefaultMovieDetailsDatastore()
        datastore.movie = movie

        var router: MovieDetailsWireframe = MovieDetailsRouter()
        router.viewController = view
               
        view?.presenter = presenter
        presenter.displayer = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.datastore = datastore
        interactor.output = presenter
        return view
    }

    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
}
