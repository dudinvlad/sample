//
//  MainAuthRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = MainAuthModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let signupAssemblying: SignupModule.ModuleAssemblying
        private let loginAssemblying: LoginModule.ModuleAssemblying
        private let mainFlowAssemblying: MainFlowModule.ModuleAssemblying

        required init(
            signup: SignupModule.ModuleAssemblying,
            login: LoginModule.ModuleAssemblying,
            main: MainFlowModule.ModuleAssemblying
        ) {
            self.signupAssemblying = signup
            self.loginAssemblying = login
            self.mainFlowAssemblying = main
        }
    }
}

extension Router: Module.RouterInput {
    func showLoginFlow() {
        viewController.navigationController?.pushViewController(loginAssemblying.assemble(), animated: true)
    }

    func showSignUpFlow() {
        viewController.navigationController?.pushViewController(signupAssemblying.assemble(), animated: true)
    }

    func showMainFlow() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = UINavigationController(rootViewController: mainFlowAssemblying.assemble())
    }
}
