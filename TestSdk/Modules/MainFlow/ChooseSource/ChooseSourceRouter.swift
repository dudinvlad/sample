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
        private let subscriptionAssemblying: SubscriptionsModule.ModuleAssemblying
        private let spotifySourceAssemblying: ChooseSourceModule.ModuleAssemblying
        private let spotifySearchAssemblying: SpotifySearchMusicModule.ModuleAssemblying
        private let userDefaultsManager: UserDefaultsManager

        required init(
            spotifyMusic: SpotifyMusicModule.ModuleAssemblying,
            userDefaultsManager: UserDefaultsManager,
            offlineMusic: OfflineMusicModule.ModuleAssemblying,
            subscription: SubscriptionsModule.ModuleAssemblying,
            spotifySourceAssemblying: ChooseSourceModule.ModuleAssemblying,
            spotifySearchAssemblying: SpotifySearchMusicModule.ModuleAssemblying
        ) {
            self.spotifyMusicAssemblying = spotifyMusic
            self.userDefaultsManager = userDefaultsManager
            self.offlineMusicAssemblying = offlineMusic
            self.subscriptionAssemblying = subscription
            self.spotifySourceAssemblying = spotifySourceAssemblying
            self.spotifySearchAssemblying = spotifySearchAssemblying
        }
    }
}

extension Router: Module.RouterInput {
    func showSpotifyMusic(with response: SavedTracksResponseModel?) {
        viewController.navigationController?.pushViewController(spotifyMusicAssemblying.assemble(response), animated: true)
    }

    func showSpotifySearchMusic() {
        viewController.navigationController?.pushViewController(spotifySearchAssemblying.assemble(), animated: true)
    }

    func showSpotifySource() {
        viewController.navigationController?.pushViewController(spotifySourceAssemblying.assemble(isSpotifyAuth: true), animated: true)
    }

    func showOfflineMusic() {
        viewController.navigationController?.pushViewController(offlineMusicAssemblying.assemble(), animated: true)
    }

    func showSubscriptionFlow() {
        viewController.present(subscriptionAssemblying.assemble(), animated: true, completion: nil)
    }
}
