//
//  FavoriteMovieCollectionViewCell.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 30/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

class FavoriteMovieCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    typealias T = FavoriteMovieViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.darkGray
        label.text = "text"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    func bind(_ item: FavoriteMovieViewModel, at indexPath: IndexPath) {
        backgroundColor = UIColor.green
        titleLabel.text = item.title
    }
    
    private func setupLayout() {
        addSubview(equalConstraintsFor: titleLabel)
    }
}
