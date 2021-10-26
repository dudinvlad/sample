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

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init()
            let interactor: Interactor = .init()
            let router: Router         = .init(
                signup: signupAssemblying,
                login: loginAssemblying
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
