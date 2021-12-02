//
//  SpotifySearchMusicRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 16.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifySearchMusicModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!

        required init() { }
    }
}

extension Router: Module.RouterInput {
    func showRootMusicScreen() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
