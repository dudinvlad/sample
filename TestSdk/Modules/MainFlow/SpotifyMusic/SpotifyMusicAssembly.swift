//
//  SpotifyMusicAssembly.swift
//  TestSdk
//
//  Created Vladislav Dudin on 07.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Macaroni

private typealias Module = SpotifyMusicModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var storageService: (StorageService & SoundtrackStoreService)!
        @Injected var spotifyService: SpotifyService!

        func assemble(_ inputData: SavedTracksResponseModel) -> UIViewController {
            let viewController: View   = .init(inputData)
            let presenter: Presenter   = .init(
                storageService: storageService,
                data: inputData
            )
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
