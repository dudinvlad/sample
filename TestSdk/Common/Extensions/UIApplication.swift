//
//  UIApplication.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import UIKit

extension UIApplication {
  func topMostViewController() -> UIViewController? {
    return UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.topMostViewController()
  }
}
