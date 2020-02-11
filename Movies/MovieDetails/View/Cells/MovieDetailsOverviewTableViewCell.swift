//
//  MovieDetailsOverviewTableViewCell.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import UIKit

class MovieDetailsOverviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratingButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func apply(model: MovieDetailsOverviewCellModel) {
        if let imageFilePath = model.posterImagePath {
            DefaultMediaStore().mediaFor(filePath: imageFilePath) { [weak self] (imageData, error) in
                guard let data = imageData else {
                    return
                }
                let image = UIImage(data: data)
                self?.posterImageView.image = image
            }
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.overview
        genreLabel.text = model.genreText
        ratingButton.backgroundColor = model.ratingViewModel?.ratingTint
        ratingButton.setTitle(model.ratingViewModel?.ratingText, for: .normal)
    }
}
