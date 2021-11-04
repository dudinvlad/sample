//
//  ChooseSourceRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let subscriptionsModule: SubscriptionsModule.ModuleAssemblying

        required init(subscriptionsModule: SubscriptionsModule.ModuleAssemblying) {
            self.subscriptionsModule = subscriptionsModule
        }
    }
}

extension Router: Module.RouterInput {
    func presentSubscriptionsModule() {
        viewController.present(subscriptionsModule.assemble(), animated: true, completion: nil)
    }
}
