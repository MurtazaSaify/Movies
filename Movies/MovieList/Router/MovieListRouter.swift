//
//  MovieListRouter.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter: MovieListWireframe {

    var viewController: UIViewController?

    // Method to setup modeule and inject dependencies for each VIPER component.
    static func createModule() -> MovieListViewController? {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController

        var presenter: MovieListPresentationLogic & MovieListBusinessLogicOutput = MovieListPresenter()
        var interactor: MovieListBusinessLogic = MovieListInteractor()
        let datastore: MovieListDatastore = DefaultMovieListDatastore()
        let remoteListWorker: FetchMovieListUseCase = FetchRemoteMovieListWorker(apiManager: DefaultMovieAPIManager())
        let localListWorker: FetchMovieListUseCase & CacheMovieListUseCase = OfflineMovieListWorker()
        let searchMovieListWorker: SearchMovieListUseCase = SearchMovieListWorker()

        var router: MovieListWireframe = MovieListRouter()
        router.viewController = view
               
        view?.presenter = presenter
        presenter.displayer = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.remoteMovieListWorker = remoteListWorker
        interactor.offlineMovieListWorker = localListWorker
        interactor.searchMovieWorker = searchMovieListWorker
        interactor.datastore = datastore
        interactor.output = presenter
        return view
    }

    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main", bundle: Bundle.main)
    }
}
