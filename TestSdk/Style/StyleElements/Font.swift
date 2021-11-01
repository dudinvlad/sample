//
//  Font.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

extension Style.Font {
    enum FontName: String {
        case bold = "Quicksand-Bold"
        case light = "Quicksand-Light"
        case medium = "Quicksand-Medium"
        case regular = "Quicksand-Regular"
        case semiBold = "Quicksand-SemiBold"
    }
    private static func bold(size: CGFloat) -> UIFont {
        makeFont(.bold, size)
    }
    private static func light(size: CGFloat) -> UIFont {
        makeFont(.light, size)
    }
    private static func medium(size: CGFloat) -> UIFont {
        makeFont(.medium, size)
    }
    private static func regular(size: CGFloat) -> UIFont {
        makeFont(.regular, size)
    }
    private static func semiBold(size: CGFloat) -> UIFont {
        makeFont(.semiBold, size)
    }

    // MARK: - Public

    static let authTitleBold = makeFont(.bold, 16)
    static let inputRegular = makeFont(.regular, 16)
    static let authDescriptionRegular = makeFont(.light, 16)
    static let priceDescriptionSmall = makeFont(.light, 14)
    static let titleBold = makeFont(.bold, 20)

    // MARK: - Private
    private static func customizeNumbers(in font: UIFont, size: CGFloat) -> UIFont {
        let numberUppercaseAttributes = [
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kUpperCaseNumbersSelector
        ]
        let newDescriptor = font.fontDescriptor.addingAttributes([
            .featureSettings: numberUppercaseAttributes
        ])
        return UIFont(descriptor: newDescriptor, size: size)
    }

    private static func makeFont(_ name: FontName, _ size: CGFloat) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size) {
            return customizeNumbers(in: font, size: size)
        } else {
            return .systemFont(ofSize: size, weight: .regular)
        }
    }
}

