//
//  CollectionDataProvider.swift
//  Shuffle Songs
//
//  Created by Érico Perez Neto on 05/08/19.
//  Copyright © 2019 Érico Perez Neto. All rights reserved.
//

import Foundation

public protocol CollectionDataProvider {
    associatedtype T
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    func updateItem(at indexPath: IndexPath, value: T)
}
