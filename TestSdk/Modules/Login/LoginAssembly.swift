//
//  LoginAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = LoginModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var authService: AuthService!
        @Injected var keychainService: StoreProtocol!
        @Injected var mainFlowAssemblying: MainFlowModule.ModuleAssemblying!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(keychainService: keychainService)
            let interactor: Interactor = .init(
                authService: authService
            )
            let router: Router         = .init(
                mainFlow: mainFlowAssemblying
            )

            viewController.output = presenter

            presenter.view       = viewController
            presenter.router     = router
            presenter.interactor = interactor

            interactor.output = presenter

            router.viewController = viewController

            return viewController
        }
    }
}
