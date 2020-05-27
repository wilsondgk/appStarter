//
//  BaseNavigationController.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    public var colorProvider: AppColorsProtocol = AppColorsDefault()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = colorProvider.mainColor
        navigationBar.tintColor = colorProvider.secondaryColor
        navigationBar.isTranslucent = true
    }
}
