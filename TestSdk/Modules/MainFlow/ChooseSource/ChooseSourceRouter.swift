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
        private let userDefaultsManager: UserDefaultsManager

        required init(
            spotifyMusic: SpotifyMusicModule.ModuleAssemblying,
            userDefaultsManager: UserDefaultsManager
        ) {
            self.spotifyMusicAssemblying = spotifyMusic
            self.userDefaultsManager = userDefaultsManager
        }
    }
}

extension Router: Module.RouterInput {
    func showSpotifyMusic(_ tracks: [SpotifyTrack]) {
        viewController.navigationController?.pushViewController(spotifyMusicAssemblying.assemble(tracks), animated: true)
    }
}
