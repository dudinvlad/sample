//
//  UIColor+Extension.swift
//  TestSdk
//
//  Created by macuser on 10/29/21.
//

import UIKit

extension UIView {
    func setGradientBackground(
        topColor: UIColor,
        bottomColor: UIColor,
        locations: [NSNumber]? = [0.0, 1.0]
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = locations
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at:0)
    }

}
