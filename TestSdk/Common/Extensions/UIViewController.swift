//
//  UIViewController.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {

        if let presented = self.presentedViewController, !presented.isBeingDismissed {
                return presented.topMostViewController()
            }

        if let navigation = self as? UINavigationController, let visibleViewController = navigation.visibleViewController, !visibleViewController.isBeingDismissed {
                return visibleViewController.topMostViewController()
            }

            if let tab = self as? UITabBarController {
                return tab.selectedViewController?.topMostViewController() ?? tab
            }

            return self
        }

    func showAlert(with message: String?, title: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
