//
//  FavoriteMoviesCollectionViewDataSource.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 30/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

class FavoriteMoviesCollectionViewDataSource: CollectionArrayDataSource<FavoriteMovieViewModel, FavoriteMovieCollectionViewCell>, UICollectionViewDelegateFlowLayout {
    
    let collectionInsets: CGFloat = 12
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width
        let cellHeight = cellWidth * 0.5
        return CGSize(width: cellWidth, height: cellHeight);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionInsets, left: collectionInsets, bottom: collectionInsets, right: collectionInsets);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionInsets
    }
}

