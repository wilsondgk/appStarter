//
//  AppColors.swift
//  AppStarter
//
//  Created by Wilson Kim on 27/05/20.
//

import Foundation

public protocol AppColorsProtocol {
    var mainColor: UIColor { get }
    var secondaryColor: UIColor { get }
}

class AppColorsDefault: AppColorsProtocol {
    var mainColor = UIColor.blue
    var secondaryColor = UIColor.red
}
