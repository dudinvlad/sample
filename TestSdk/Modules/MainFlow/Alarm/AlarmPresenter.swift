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

        private let notificationManager: NotificationManager

        required init(
            notificationManager: NotificationManager)
        {
            self.notificationManager = notificationManager
        }
    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func showChooseMusic() {
        router.presentChooseMusic()
    }

    func fireAlarm() {
        let date = view.getSelectedTime()
        notificationManager.scheduleNotification(dateTime: date)
    }
}

extension Presenter: Module.InteractorOutput {
    var controller: BaseViewInput? {
        view
    }
}
