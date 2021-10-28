//
//  LoginRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = LoginModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let mainFlowAssemblying: MainFlowModule.ModuleAssemblying

        required init(mainFlow: MainFlowModule.ModuleAssemblying) {
            self.mainFlowAssemblying =  mainFlow
        }
    }
}

extension Router: Module.RouterInput {
    func showMainFlow() {
        UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController = UINavigationController(rootViewController: mainFlowAssemblying.assemble())
    }
}
