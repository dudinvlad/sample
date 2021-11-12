//
//  OfflineMusicInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 10.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = OfflineMusicModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!
        private let soundtrackService: SoundtrackService

        required init(soundtrackService: SoundtrackService) {
            self.soundtrackService = soundtrackService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func fetchDefaultsTracks() {
        soundtrackService.fetchDefaultsSoundtracks { response, error in
            self.output.controller?.hideActivity()
            if let error = error {
                self.output.controller?.showNetworking(error: error)
                return
            }

            self.output.successDefaultsTracks(response)
        }
    }
}
