//
//  GradientView.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 04/04/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.commonInit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.commonInit();
    }
    
    func commonInit() {
        backgroundColor = .clear
        let gradient = CAGradientLayer();
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height);
        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor];
        self.layer.insertSublayer(gradient, at: 0);
        self.alpha = 0.5;
    }
}

