//
//  MainAuthAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = MainAuthModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var signupAssemblying: SignupModule.ModuleAssemblying!
        @Injected var loginAssemblying: LoginModule.ModuleAssemblying!
        @Injected var mainFlowAssemblying: MainFlowModule.ModuleAssemblying!
        @Injected var keychainService: StoreProtocol!
        @Injected var storageService: StorageService!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(
                keychainService: keychainService,
                storageService: storageService
            )
            let interactor: Interactor = .init()
            let router: Router         = .init(
                signup: signupAssemblying,
                login: loginAssemblying,
                main: mainFlowAssemblying
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
