//
//  ChooseSourcePresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let spotifyManager: SpotifyManager

        required init(with spotify: SpotifyManager) {
            self.spotifyManager = spotify
        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func presentSubscriptionsModule() {
        router.presentSubscriptionsModule()
    }

    func requestSpotifyConnect() {
        spotifyManager.connect { [weak self] code in
            self?.interactor.exchangeToken(with: code)
        }
    }
}

extension Presenter: Module.InteractorOutput {
    func spotifySuccess(with accessToken: String) {
        spotifyManager.appRemote.connectionParameters.accessToken = accessToken
        KeychainStore().set(accessToken, key: "spotify_access_token")
        interactor.fetchSavedTracks()
    }

    func success(with tracks: [SpotifyTrack]) {
        
    }

    var controller: BaseViewInput? {
        view
    }
}
