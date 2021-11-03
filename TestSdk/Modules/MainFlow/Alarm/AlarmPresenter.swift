//
//  AlarmPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = AlarmModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let spotifyManager: SpotifyManager
        private let notificationManager: NotificationManager

        required init(
            with spotify: SpotifyManager,
            notificationManager: NotificationManager)
        {
            self.spotifyManager = spotify
            self.notificationManager = notificationManager
        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func requestSpotifyConnect() {
        let timeInterval = view.getSelectedTime()
        notificationManager.scheduleNotification(identifier: "\(timeInterval)", soundName: "", timeInterval: timeInterval)
    }

    func presentSubscriptionsModule() {
        router.presentSubscriptionsModule()
    }
}

extension Presenter: Module.InteractorOutput {
    var controller: BaseViewInput? {
        view
    }
}
