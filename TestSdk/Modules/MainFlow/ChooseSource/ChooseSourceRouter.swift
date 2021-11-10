//
//  ChooseSourceRouter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!
        private let spotifyMusicAssemblying: SpotifyMusicModule.ModuleAssemblying
        private let offlineMusicAssemblying: OfflineMusicModule.ModuleAssemblying
        private let userDefaultsManager: UserDefaultsManager

        required init(
            spotifyMusic: SpotifyMusicModule.ModuleAssemblying,
            userDefaultsManager: UserDefaultsManager,
            offlineMusic: OfflineMusicModule.ModuleAssemblying
        ) {
            self.spotifyMusicAssemblying = spotifyMusic
            self.userDefaultsManager = userDefaultsManager
            self.offlineMusicAssemblying = offlineMusic
        }
    }
}

extension Router: Module.RouterInput {
    func showSpotifyMusic(with response: SavedTracksResponseModel) {
        viewController.navigationController?.pushViewController(spotifyMusicAssemblying.assemble(response), animated: true)
    }

    func showOfflineMusic(with items: [SpotifyTrack]) {
        viewController.navigationController?.pushViewController(offlineMusicAssemblying.assemble(items), animated: true)
    }
}
