//
//  BaseViewController.swift
//  TheMovieApp
//
//  Created by Wilson Kim on 24/06/19.
//  Copyright © 2019 WilsonKim. All rights reserved.
//

import UIKit
import CoreData

typealias ActionTuple = (title: String, style: UIAlertAction.Style?, action: ((UIAlertAction) -> Void)?)

class BaseViewController: UIViewController {
    
    let errorView = ErrorView(frame: CGRect.zero)
    let loadingView = LoadingView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
    }
    
    func setNormalLayout() {
        errorView.removeFromSuperview()
        loadingView.removeFromSuperview()
    }
    
    func showError(_ error: Error?) {
        showError(error, onView: nil)
    }
    
    func showError(_ error: Error?, title: String? = nil) {
        showError(error, onView: nil, title: title)
    }
    
    func showError(_ error:Error?, onView view:UIView? = nil, title: String? = nil) {
        showErrorView(getErrorMessageFrom(error: error), aView: view ?? self.view, title: title ?? getErrorTitleFrom(error: error))
    }
    
    func getErrorMessageFrom(error: Error?) -> String {
        if let error = error {
            return error.localizedDescription
        } else {
            return "Houve um erro na requisição. Tente novamente mais tarde"
        }
    }
    
    func getErrorTitleFrom(error: Error?) -> String {
        if let error = error {
            return "Código de Erro: \(error._code)"
        } else {
            return "Houve um erro"
        }
    }
    
    func showErrorView(_ message:String, aView:UIView, title: String) {
        errorView.title.text = title
        errorView.message.text = message
        hideLoading()
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            errorView.leadingAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            errorView.topAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            errorView.trailingAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            errorView.bottomAnchor.constraint(equalTo: aView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            errorView.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 0).isActive = true
            errorView.topAnchor.constraint(equalTo: aView.topAnchor, constant: 0).isActive = true
            errorView.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: 0).isActive = true
            errorView.bottomAnchor.constraint(equalTo: aView.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    func showErrorAlert(_ error:Error?) {
        showAlert(_title: getErrorTitleFrom(error: error), _message: getErrorMessageFrom(error: error))
    }
    
    func showParsingErrorAlert() {
        showAlert(title: "Erro de parseamento", message: "Erro de parseamento. Favor contactar o administrador do aplicativo", withButtonsAndActions: nil)
    }
    
    func showAlert(_title:String, _message:String) {
        showAlert(title: _title, message: _message, withButtonsAndActions: nil)
    }
    
    func setRetryErrorBlock(_ errorBlock:@escaping () -> Void) {
        errorView.setCompletion {
            errorBlock()
        }
    }
    
    func hideErrorView() {
        errorView.removeFromSuperview()
    }
    
    func createError(_ bundle:String = "com.appCompany.AppName", _ code:Int = 7779, _ message:String = "Erro de formatação no erro.") -> Error {
        return NSError(domain: bundle, code:7779, userInfo:[ NSLocalizedDescriptionKey: message])
    }
    
    func showLoading(withMessage message: String) {
        showLoadingInView(nil, withMessage: message)
    }
    
    func showLoadingInView(_ aView:UIView? = nil, withMessage message:String? = nil) {
        let containerView: UIView = aView == nil ? self.view : aView!
        hideErrorView()
        loadingView.setLoadingMessage(message)
        containerView.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            loadingView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            loadingView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            loadingView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            loadingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
            loadingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
            loadingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    func hideLoading() {
        loadingView.removeFromSuperview()
    }
    
    func showAlert(title: String, message: String?, style: UIAlertController.Style? = .alert, withButtonsAndActions tuples: [ActionTuple]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
        
        if let tuples = tuples {
            for tuple in tuples {
                let action = UIAlertAction(title: tuple.title, style: tuple.style ?? .default, handler: tuple.action)
                alert.addAction(action)
            }
        } else {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
