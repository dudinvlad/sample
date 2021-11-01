//
//  AlarmAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = AlarmModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var subscriptionsModule: SubscriptionsModule.ModuleAssemblying!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init()
            let interactor: Interactor = .init()
            let router: Router         = .init(with: subscriptionsModule)

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
