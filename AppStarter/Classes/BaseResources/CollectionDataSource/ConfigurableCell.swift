//
//  ConfigurableCell.swift
//  Shuffle Songs
//
//  Created by Érico Perez Neto on 05/08/19.
//  Copyright © 2019 Érico Perez Neto. All rights reserved.
//

import Foundation

protocol ConfigurableCell: ReusableCell {
    associatedtype T
    func bind(_ item: T, at indexPath: IndexPath)
}
