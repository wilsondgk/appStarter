//
//  DefaultMovieDataSource.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 27/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

class DefaultMovieDataSource: CollectionArrayDataSource<DefaultMovieViewModel, MovieCollectionViewCell>, UICollectionViewDelegateFlowLayout {
    
    let collectionInsets: CGFloat = 12
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.width - (3 * collectionInsets)) / 2
        let cellHeight = cellWidth * 1.5 + 111

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
