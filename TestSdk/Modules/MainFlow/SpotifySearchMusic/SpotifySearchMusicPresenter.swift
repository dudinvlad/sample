//
//  SpotifySearchMusicPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 16.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifySearchMusicModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Variables

        private lazy var totalTracks: Int = .zero
        private lazy var offsetTracks: Int = .zero
        private var lastQuery: String?

        // MARK: - Dependencies

        private let storageService: (StorageService & SoundtrackStoreService)

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        required init(
            storageService: (StorageService & SoundtrackStoreService)
        ) {
            self.storageService = storageService
        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func saveSelectedTrack(_ track: SpotifyTrack) {
        guard track.previewUrl != nil else { view.showNetworking(error: "Sorry! This track is not available"); return }

        storageService.saveTracks([track])
        router.showRootMusicScreen()
    }

    func requestMoreSearchTracks() {
        guard
            offsetTracks < totalTracks,
            let query = lastQuery
        else { return }

        interactor.searchTracks(with: query, offset: offsetTracks)
    }

    func requestSearch(_ query: String) {
        guard !query.isEmpty else { return }

        self.lastQuery = query
        interactor.searchTracks(with: query, offset: .zero)
    }
}

extension Presenter: Module.InteractorOutput {
    func success(with data: SearchTracksResponseModel?) {
        guard let trackResponse = data else { return }

        self.totalTracks = trackResponse.total
        self.offsetTracks += trackResponse.items.count
        view.updateTracks(with: trackResponse.items)
    }

    var controller: BaseViewInput? {
        view
    }
}
