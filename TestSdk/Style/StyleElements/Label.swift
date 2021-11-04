//
//  Label.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

extension Style.Label {
    static let inputTitleLabel = ColoredLabel(
        titleColor: .black,
        font: Style.Font.authTitleBold
    )
    static let infoLabel = ColoredLabel(
        titleColor: Style.Color.nightBlue,
        font: Style.Font.infoMedium,
        align: .center
    )

    static let titleLabel = ColoredLabel(
        titleColor: .white,
        font: Style.Font.titleBold
    )

    static let descriptionLabel = ColoredLabel(
        titleColor: Style.Color.main,
        font: Style.Font.infoMedium,
        numberOfLines: .zero
    )
}
