//
//  UIView.swift
//  Convert Coin
//
//  Created by Glauber Gustavo on 20/12/22.
//

import UIKit

extension UIView {
    public func showMessage(viewController:UIViewController, message:String, title:String = "Atenção", btnTitle:String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btnTitle, style: .default))
        viewController.present(alert, animated: true)
    }
}
