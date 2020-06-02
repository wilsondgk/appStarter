//
//  BaseNavigationController.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = Colors.appYellow
        navigationBar.tintColor = Colors.marineBlue
        navigationBar.isTranslucent = true
    }
}
