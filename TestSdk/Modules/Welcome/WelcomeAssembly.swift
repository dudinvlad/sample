//
//  WelcomeAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = WelcomeModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var mainAuthAssemblying: MainAuthModule.ModuleAssemblying!
        @Injected var userDefaultsManager: UserDefaultsManager!
        @Injected var keychainService: StoreProtocol!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(with: userDefaultsManager, keychainStore: keychainService)
            let interactor: Interactor = .init()
            let router: Router         = .init(
                mainAuth: mainAuthAssemblying
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
