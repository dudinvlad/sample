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
        @Injected var notificationManager: NotificationManager!
        @Injected var userDefaultsManager: UserDefaultsManager!
        @Injected var storageService: StorageService!
        @Injected var spotifyMusicAssemblying: SpotifyMusicModule.ModuleAssemblying!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(
                with: spotifyManager,
                notificationManager: notificationManager,
                userDefaultsManager: userDefaultsManager,
                storageService: storageService
            )
            let interactor: Interactor = .init(
                spotifyService: spotifyService
            )
            let router: Router         = .init(
                spotifyMusic: spotifyMusicAssemblying,
                userDefaultsManager: userDefaultsManager
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
