//
//  BaseNavigationController.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 21/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController {
    
    private var colorProvider: AppColorsProtocol = AppColorsDefault()
    
    
    
    public func setColorProvider(_ provider: AppColorsProtocol) {
        self.colorProvider = provider
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = colorProvider.mainColor
        navigationBar.tintColor = colorProvider.secondaryColor
        navigationBar.isTranslucent = true
    }
}
