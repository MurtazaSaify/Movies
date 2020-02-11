//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var presenter: MovieDetailsPresentationLogic?
    
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: MovieDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
        presenter?.onViewDidLoad()
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension MovieDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        switch viewModel.sections[section] {
        case .overview:
            return 1
        case let .productionHouses(_, productionCompanyCellModels):
            return productionCompanyCellModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let viewModel = viewModel else {
            fatalError("Expecting valid instance of view model here")
        }
        switch viewModel.sections[indexPath.section] {
        case let .overview(model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsOverviewCellIdentifier") as? MovieDetailsOverviewTableViewCell else {
                fatalError("")
            }
            cell.apply(model: model)
            return cell
        case let .productionHouses(_, models):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieProductionCompanyCellIdentifier") as? MovieProductionCompanyInfoTableViewCell else {
                fatalError("")
            }
            cell.apply(model: models[indexPath.row])
            return cell
        }
    }
}

extension MovieDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else {
            fatalError("Expecting valid instance of view model here")
        }
        switch viewModel.sections[section] {
        case let .productionHouses(title, _):
            return title
        default:
            return nil
        }
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    
    func display(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        title = viewModel.viewTitle
        tableView.reloadData()
    }
}
