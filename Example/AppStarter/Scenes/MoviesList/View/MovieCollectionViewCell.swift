//
//  MovieCollectionViewCell.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 27/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

class MovieCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    typealias T = DefaultMovieViewModel
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var yearAndLengthLabel: UILabel!
    @IBOutlet private weak var isFavoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
    }

    func bind(_ item: DefaultMovieViewModel, at indexPath: IndexPath) {
        titleLabel.text = item.name
        ratingLabel.text = item.ratingText
        yearAndLengthLabel.text = item.yearAndLengthText
        movieImageView.loadImageFrom(path: item.posterPath)
        isFavoriteImageView.image = UIImage(named: item.favoriteIconImage)
    }
}
