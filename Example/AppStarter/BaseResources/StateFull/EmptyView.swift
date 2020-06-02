//
//  EmptyView.swift
//  storeappios
//
//  Created by Wilson Kim on 25/06/19.
//  Copyright © 2019 RevMob. All rights reserved.
//

import UIKit

@IBDesignable
class EmptyView: UIView, UpdateStateProtocol {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private var mainImageView: UIImageView!
    @IBOutlet private var errorMessageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadViewFromNib()
        setup()
    }
    
    private func setup() {
        contentView.layer.cornerRadius = 16
    }
    
    func setEmptyMessage(_ message:String?) {
        errorMessageLabel.text = message
    }
    
    func setImage(_ image:UIImage?) {
        mainImageView.image = image
    }
    
    //MARK: UpdateStateProtocol
    func shouldUpdateView(withState state: ViewStateEnum) {
        switch state {
        case let .empty(emptyMessage: message, image: image):
            if let image = image { setImage(image) }
            setEmptyMessage(message)
            isHidden = false
            break
        default:
            isHidden = true
        }
    }
}
