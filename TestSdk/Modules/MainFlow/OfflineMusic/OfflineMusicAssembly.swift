//
//  OfflineMusicAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 10.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = OfflineMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var storageService: StorageService!

        func assemble(_ items: [SpotifyTrack]) -> UIViewController {
            let viewController: View   = .init(items)
            let presenter: Presenter   = .init(storageService: storageService)
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
