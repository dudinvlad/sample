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

        required init(
            signup: SignupModule.ModuleAssemblying,
            login: LoginModule.ModuleAssemblying
        ) {
            self.signupAssemblying = signup
            self.loginAssemblying = login
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
}
