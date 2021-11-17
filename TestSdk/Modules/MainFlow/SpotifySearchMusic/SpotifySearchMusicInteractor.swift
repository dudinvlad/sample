//
//  SpotifySearchMusicInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 16.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifySearchMusicModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!
        private let spotifyService: SpotifyService

        // MARK: - Variables

        private var searchItem: DispatchWorkItem?

        // MARK: - Init

        required init(spotifyService: SpotifyService) {
            self.spotifyService = spotifyService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func searchTracks(with query: String, offset: Int) {
        searchItem?.cancel()
        let task = DispatchWorkItem { [weak self] in
            self?.spotifyService.searchTracks(with: query, offset: offset) { response, error in
                if let error = error {
                    self?.output.controller?.showNetworking(error: error)
                    return
                }
                self?.output.success(with: response?.tracks)
            }
        }

        searchItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: task)
    }
}
