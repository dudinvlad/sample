//
//  MainFlowAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = MainFlowModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var alarmAssemblying: AlarmModule.ModuleAssemblying!
        @Injected var aboutUsAssemblying: AboutUsModule.ModuleAssemblying!

        func assemble() -> UITabBarController {
            let viewController: View   = .init([alarmAssemblying.assemble(), aboutUsAssemblying.assemble()])
            let presenter: Presenter   = .init()
            let interactor: Interactor = .init()
            let router: Router         = .init()

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
