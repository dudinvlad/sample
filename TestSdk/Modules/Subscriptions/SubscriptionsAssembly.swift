//
//  SubscriptionsAssembly.swift
//  TestSdk
//
//  Created macuser on 10/29/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = SubscriptionsModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var purchaseManager: PurchaseManager!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(with: purchaseManager)
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
