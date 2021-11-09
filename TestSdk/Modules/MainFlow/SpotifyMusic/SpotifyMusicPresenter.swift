//
//  SpotifyMusicPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 07.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SpotifyMusicModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let storageService: StorageService
        private var data: SavedTracksResponseModel

        private lazy var totalTracks: Int = data.total
        private lazy var offsetTracks: Int = data.items.map { $0.track}.count

        required init(
            storageService: StorageService,
            data: SavedTracksResponseModel
        ) {
            self.storageService = storageService
            self.data = data
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

    func requestMoreSaveTrack() {
        guard offsetTracks < totalTracks else { return }

        interactor.fetchSavedTracks(with: offsetTracks)
    }
}

extension Presenter: Module.InteractorOutput {
    func success(with data: SavedTracksResponseModel) {
        self.totalTracks = data.total
        self.offsetTracks += data.items.map { $0.track }.count
        view.updateTracks(with: data.items.map { $0.track })
    }

    var controller: BaseViewInput? {
        view
    }
}
