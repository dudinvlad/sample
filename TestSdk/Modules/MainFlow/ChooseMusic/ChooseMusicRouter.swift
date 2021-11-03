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
        private let subscriptionsModule: SubscriptionsModule.ModuleAssemblying
        private let chooseSourceModule: ChooseSourceModule.ModuleAssemblying

        required init(
            subscriptionsModule: SubscriptionsModule.ModuleAssemblying,
            chooseSourceModule: ChooseSourceModule.ModuleAssemblying
        ) {
            self.subscriptionsModule = subscriptionsModule
            self.chooseSourceModule = chooseSourceModule
        }
    }
}

extension Router: Module.RouterInput {
    func presentSubscriptionsModule() {
        viewController.present(subscriptionsModule.assemble(), animated: true, completion: nil)
    }

    func showChooseSourceModule() {
        viewController.navigationController?.pushViewController(chooseSourceModule.assemble(), animated: true)
    }
}
