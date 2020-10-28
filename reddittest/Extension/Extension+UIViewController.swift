//
//  Extension+UIViewController.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func loadViewControllerXib<T>() -> T where T: UIViewController {
        return T(nibName: T.className, bundle: nil)
    }
    
    func loadNib<T: NSObject>() -> T? {
        return Bundle.main.loadNibNamed(T.className, owner: nil, options: [:])?.first as? T
    }
    
    func showAlert(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [UIAlertAction(title: Strings.ok, style: .cancel)]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { actionSheet.addAction($0) }
        
        if let currentAlertController = self.presentedViewController as? UIAlertController {
            currentAlertController.dismiss(animated: true) {
                self.present(actionSheet, animated: true, completion: nil)
            }
        } else {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}

// MARK: - Show loading spinner
extension UIViewController {
    
    func presentSpinner(style: UIActivityIndicatorView.Style = .large) {
        if let activityIndicator = findActivity() {
            activityIndicator.startAnimating()
        } else {
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            
            view.addConstraintsWithFormat(format: "H:|[v0]|", views: activityIndicator)
            view.addConstraintsWithFormat(format: "V:|[v0]|", views: activityIndicator)
        }
        
        view.isUserInteractionEnabled = false
    }
    
    func dismissSpinner() {
        findActivity()?.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    private func findActivity() -> UIActivityIndicatorView? {
        return view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
}
