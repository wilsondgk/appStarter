//
//  String+extension.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 25/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

extension String {
    init(key: String) {
        self.init(Bundle.main.localizedString(forKey: key, value: nil, table: "Localizable"))
    }
}
