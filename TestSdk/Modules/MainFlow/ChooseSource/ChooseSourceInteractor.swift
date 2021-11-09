//
//  ChooseSourceInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = ChooseSourceModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!

        private let spotifyService: SpotifyService

        required init(spotifyService: SpotifyService) {
            self.spotifyService = spotifyService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func exchangeToken(with code: String) {
        spotifyService.exchangeAccessToken(with: code) { [weak self] accessToken, error in
            self?.output.spotifySuccess(with: accessToken)
        }
    }

    func fetchSavedTracks() {
        spotifyService.loadSavedTracks { [weak self] response, error in
            self?.output.success(with: response)
        }
    }

    func startPlayback(with device: String, uri: String) {
        spotifyService.startPlayback(with: device, uri: uri)
    }
}
