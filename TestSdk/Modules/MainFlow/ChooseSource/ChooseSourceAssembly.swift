//
//  ChooseSourceAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = ChooseSourceModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var spotifyManager: SpotifyManager!
        @Injected var spotifyService: SpotifyService!
        @Injected var subscriptionsModule: SubscriptionsModule.ModuleAssemblying!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(
                with: spotifyManager
            )
            let interactor: Interactor = .init(
                spotifyService: spotifyService
            )
            let router: Router         = .init(
                subscriptionsModule: subscriptionsModule
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
