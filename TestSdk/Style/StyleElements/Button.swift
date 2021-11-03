//
//  Button.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 23.10.2021.
//

import UIKit

extension Style.Button {
    static let authButton = ColoredButton(
        background: .white,
        border: .gray,
        title: .black,
        font: Style.Font.authTitleBold,
        cornerRadius: 5
    )

    static let authConfirmButton = ColoredButton(
        background: Style.Color.nightBlue,
        title: .white,
        font: Style.Font.authTitleBold,
        cornerRadius: 5
    )

    static let spotifyButton = ColoredButton(background: .clear, title: .white, font: Style.Font.titleBold, cornerRadius: 5)
}
