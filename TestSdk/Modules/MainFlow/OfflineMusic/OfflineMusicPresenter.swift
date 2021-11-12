//
//  OfflineMusicPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 10.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = OfflineMusicModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let soundStoreService: (StorageService & SoundtrackStoreService)

        required init(
            soundStoreService: (StorageService & SoundtrackStoreService)
        ) {
            self.soundStoreService = soundStoreService
        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func saveSelectedTrack(_ track: Soundtrackable) {
        guard !track.soundtrackPath.isEmpty else { view.showNetworking(error: "Sorry! This track is not available"); return }

        soundStoreService.saveTracks([track])
        router.showRootMusicScreen()
    }

    func requestDefaultTracks() {
        view.showActivity()
        interactor.fetchDefaultsTracks()
    }
}

extension Presenter: Module.InteractorOutput {
    func successDefaultsTracks(_ items: [Soundtrackable]?) {
        view.hideActivity()
        guard let soundtracks = items else { return }

        view.update(with: soundtracks)
    }

    var controller: BaseViewInput? {
        view
    }
}
