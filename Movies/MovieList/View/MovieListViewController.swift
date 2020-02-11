//
//  MovieListViewController.swift
//  Movies
//
//  Created by Murtuza Saify on 2/8/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    var presenter: MovieListPresentationLogic?
    private var cellModels: [MovieListCellModel]?
    private var segmentedControlViewModel: MovieListCriteriaSegmentViewModel?

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.onViewDidLoad()
        configureCollectionView()
        title = "Movies"
    }
}

extension MovieListViewController {

    private func configureCollectionView() {

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: collectionView.bounds.width, height: 200)
        let horizontalInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
    }

    @IBAction private func onSegmentedControlValueChanged() {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        guard let criteria = segmentedControlViewModel?.criterias[selectedSegmentIndex] else {
            return
        }
        collectionView.contentOffset = .zero
        presenter?.onSelect(criteria: criteria)
    }
}

extension MovieListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell,
              let cellModel = cellModels?[indexPath.item] else {
            fatalError("Expecting valid instance of cell here")
        }
        cell.apply(model: cellModel)
        cell.maxWidth = UIDevice.current.userInterfaceIdiom == .phone ? collectionView.bounds.width : (collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right - 10) / 2
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        // Logic to make a call to fetch next page data on reaching list end.
        guard let cellCount = cellModels?.count,
              indexPath.item >= cellCount - 1 else {
            return
        }
        presenter?.loadMoreDataOnReachingListEnd()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieId = cellModels?[indexPath.item].movieId else {
            return
        }
        presenter?.onSelectMovieWith(id: movieId)
    }
}

extension MovieListViewController: MovieListDisplayLogic {

    // Cell models received from presenter.
    func display(cellModels: [MovieListCellModel]) {
        self.cellModels = cellModels
        collectionView.reloadData()
    }

    // Criterias model recieved from presenter.
    func display(listingCriterias: MovieListCriteriaSegmentViewModel) {
        segmentedControl.removeAllSegments()
        for i in 0..<listingCriterias.criterias.count {
            let criteria = listingCriterias.criterias[i]
            segmentedControl.insertSegment(withTitle: criteria.displayName(), at: i, animated: false)
        }
        segmentedControlViewModel = listingCriterias
        segmentedControl.selectedSegmentIndex = 0
        onSegmentedControlValueChanged()
    }
}

extension MovieListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.onSearchTermChangeTo(searchTerm: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MovieListViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder,
           scrollView.isDragging {
            searchBar.resignFirstResponder()
        }
    }
}

