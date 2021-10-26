//
//  UIView.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

extension UIView {
    func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func makeCircle() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }

    func addBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
