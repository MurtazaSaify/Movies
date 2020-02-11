//
//  MovieListCollectionViewCell.swift
//  Movies
//
//  Created by Murtuza Saify on 2/9/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
        didSet {
            maxWidthConstraint.isActive = false
        }
    }
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        posterImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    func apply(model: MovieListCellModel) {

        if let imageFilePath = model.imageFilePath {
            DefaultMediaStore().mediaFor(filePath: imageFilePath) { [weak self] (imageData, error) in
                guard let data = imageData else {
                    return
                }
                let image = UIImage(data: data)
                self?.posterImageView.image = image
            }
        }
        titleLabel.text = model.title
        descriptionLabel.text = model.movieDescription
        ratingLabel.text = model.ratingViewModel?.ratingText
        ratingView.backgroundColor = model.ratingViewModel?.ratingTint
    }
}
