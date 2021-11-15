//
//  SpotifyMusicInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 07.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifyMusicModule
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
    func fetchSavedTracks(with offset: Int) {
        spotifyService.loadSavedTracks(offset: offset) { [weak self] response, error in
            if let errorMessage = error {
                self?.output.controller?.showNetworking(error: errorMessage)
                return
            }
            self?.output.success(with: response)
        }
    }
}
