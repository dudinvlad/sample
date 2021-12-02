//
//  SpotifySearchMusicAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 16.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = SpotifySearchMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var storageManager: (SoundtrackStoreService & StorageService)!
        @Injected var spotifyService: SpotifyService!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init(storageService: storageManager)
            let interactor: Interactor = .init(spotifyService: spotifyService)
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
