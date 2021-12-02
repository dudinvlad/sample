//
//  ChooseMusicRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseMusicModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let chooseSourceModule: ChooseSourceModule.ModuleAssemblying

        required init(
            chooseSourceModule: ChooseSourceModule.ModuleAssemblying
        ) {
            self.chooseSourceModule = chooseSourceModule
        }
    }
}

extension Router: Module.RouterInput {
    func showChooseSourceModule() {
        viewController.navigationController?.pushViewController(chooseSourceModule.assemble(isSpotifyAuth: false), animated: true)
    }

    func dismissChooseFlow() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
