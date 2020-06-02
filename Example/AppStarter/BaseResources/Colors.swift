//
//  Colors.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 20/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit
import AppStarter

class Colors: UIColor, AppColorsProtocol {
    var mainColor: UIColor {
        return Colors.appYellow
    }
    
    var secondaryColor: UIColor {
        return Colors.marineBlue
    }
    
    static var appYellow = UIColor.fromHex(0xF7CE5B)
    static var darkYellow = UIColor.fromHex(0xD9971E)
    static var marineBlue = UIColor.fromHex(0x2D3047)
    static var backgroundGray = UIColor(red: 250/255, green: 252/255, blue: 254/255, alpha: 1.0)
}
