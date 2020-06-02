//
//  CollectionDataSource.swift
//  Shuffle Songs
//
//  Created by Érico Perez Neto on 05/08/19.
//  Copyright © 2019 Érico Perez Neto. All rights reserved.
//

import UIKit

open class CollectionDataSource<Provider: CollectionDataProvider, Cell: UICollectionViewCell>: NSObject,
UICollectionViewDelegate,
UICollectionViewDataSource
where Cell: ConfigurableCell, Provider.T == Cell.T {
    
    public typealias CollectionItemSelectionHandlerType = (IndexPath) -> Void
    
    let provider: Provider
    private let collectionView: UICollectionView
    private var dataSourceScrollViewDelegate: UIScrollViewDelegate?
    
    public init(collectionView: UICollectionView, provider: Provider) {
        self.collectionView = collectionView
        self.provider = provider
        super.init()
        setUp()
    }
    
    func setUp() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return provider.numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier,
                                                            for: indexPath) as? Cell else {
                                                                return UICollectionViewCell()
        }
        
        let item = provider.item(at: indexPath)
        
        if let item = item {
            cell.bind(item, at: indexPath)
        }
        
        return cell
    }
    
    public var collectionItemSelectionHandler: CollectionItemSelectionHandlerType?
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionItemSelectionHandler?(indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView(frame: CGRect.zero)
    }
    
    //MARK: ScrollViewDelegate
    
    public func setScrollViewDelegate(_ delegate: UIScrollViewDelegate) {
        dataSourceScrollViewDelegate = delegate
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dataSourceScrollViewDelegate?.scrollViewDidScroll?(collectionView)
    }
}
