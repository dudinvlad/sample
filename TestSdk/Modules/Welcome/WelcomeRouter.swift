//
//  WelcomeRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = WelcomeModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let mainAuthAssemblying: MainAuthModule.ModuleAssemblying

        required init(mainAuth: MainAuthModule.ModuleAssemblying) {
            self.mainAuthAssemblying = mainAuth
        }
    }
}

extension Router: Module.RouterInput {
    func showMainAuthFlow() {
        viewController.navigationController?.pushViewController(mainAuthAssemblying.assemble(), animated: true)
    }
}
