//
//  LoadingView.swift
//  CaixaUI
//
//  Created by Wilson Kim on 09/05/19.
//

import Foundation
import UIKit

class LoadingView: UIView, UpdateStateProtocol {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var messageLabel: UILabel!
    
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
        setupContainerView()
        setupLabel()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 16
        backgroundColor = UIColor.clear
    }
    
    private func setupLabel() {
        messageLabel.textColor = Colors.darkGray
    }
    
    func setLoadingMessage(_ message:String?) {
        startLoading()
        messageLabel.text = message ?? "Carregando informações..."
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    //MARK: UpdateStateProtocol
    func shouldUpdateView(withState state: ViewStateEnum) {
        
        switch state {
        case let .loading(message):
            setLoadingMessage(message)
            isHidden = false
            break
        default:
            stopLoading()
            isHidden = true
        }
    }
}

