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

        required init(storageService: StorageService) {
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
}

extension Presenter: Module.InteractorOutput {
    var controller: BaseViewInput? {
        view
    }
}
