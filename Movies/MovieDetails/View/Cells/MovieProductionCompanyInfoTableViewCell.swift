//
//  MovieProductionCompanyInfoTableViewCell.swift
//  Movies
//
//  Created by Murtuza Saify on 2/11/20.
//  Copyright © 2020 Murtuza Saify. All rights reserved.
//

import UIKit

class MovieProductionCompanyInfoTableViewCell: UITableViewCell {

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func apply(model: MovieProductionCompanyInfoCellModel) {
        if let imageFilePath = model.imagePath {
            DefaultMediaStore().mediaFor(filePath: imageFilePath) { [weak self] (imageData, error) in
                guard let data = imageData else {
                    return
                }
                let image = UIImage(data: data)
                self?.logoImageView.image = image
            }
        }
        titleLabel.text = model.title
    }
}
