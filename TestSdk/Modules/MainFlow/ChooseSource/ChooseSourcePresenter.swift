//
//  ChooseSourcePresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVFoundation

private typealias Module = ChooseSourceModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let spotifyManager: SpotifyManager
        private let notificationManager: NotificationManager
        private let userDefaultsManager: UserDefaultsManager

        required init(
            with spotify: SpotifyManager,
            notificationManager: NotificationManager,
            userDefaultsManager: UserDefaultsManager

        ) {
            self.spotifyManager = spotify
            self.notificationManager = notificationManager
            self.userDefaultsManager = userDefaultsManager

        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func requestSpotifyConnect() {
        interactor.validateReceipt()
    }
    func showOfflineMusic() {
        router.showOfflineMusic()
    }
}

extension Presenter: Module.InteractorOutput {
    func spotifySuccess(with accessToken: String?) {
        spotifyManager.appRemote.connectionParameters.accessToken = accessToken
        spotifyManager.appRemote.connect()
        KeychainStore().set(accessToken, key: "spotify_access_token")
        interactor.fetchSavedTracks()
    }

    func success(with response: SavedTracksResponseModel) {
        router.showSpotifyMusic(with: response)
    }

    func receiptValidate(with response: Bool) {
        if response {
            spotifyManager.connect { [weak self] code in
                self?.interactor.exchangeToken(with: code)
            }
        } else {
            router.showSubscriptionFlow()
        }
    }

    var controller: BaseViewInput? {
        view
    }
}
