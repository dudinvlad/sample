//
//  AlarmPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVFoundation

private typealias Module = AlarmModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let userDefaultsManager: UserDefaultsManager
        private let keychainManager: StoreProtocol
        private let notificationManager: NotificationManager

        required init(
            userDefaultsManager: UserDefaultsManager,
            notificationManager: NotificationManager,
            keychainManager: StoreProtocol
        )
        {
            self.userDefaultsManager = userDefaultsManager
            self.notificationManager = notificationManager
            self.keychainManager = keychainManager
        }
    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func didLoad() {
        notificationManager.getPendingNotifications(complition: { [weak self] time in
            guard let alarmTime = time else { return }
            
            DispatchQueue.main.async {
                self?.view.configureOnAlarm(with: alarmTime)
            }
        })
    }

    func logout() {
        keychainManager.clear()
        router.presentAuthFlow()
    }

    func willAppear() {
        router.presentSubscriptionFlow()
    }

    func showChooseMusic() {
        router.presentChooseMusic()
    }

    func fireAlarm() {
        let date = view.getSelectedTime()
        userDefaultsManager.set(date, key: UserDefaultsManager.Keys.selectedDate.rawValue)
    }

    func stopAlarm() {
        notificationManager.removeAllPendingNotificationRequests()
    }

}

extension Presenter: Module.InteractorOutput {
    var controller: BaseViewInput? {
        view
    }
}
