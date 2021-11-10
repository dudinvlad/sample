//
//  WelcomePresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = WelcomeModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let userDefaultsManager: UserDefaultsManager
        private let keychainStore: StoreProtocol

        required init(with userDefaultsManager: UserDefaultsManager, keychainStore: StoreProtocol) {
            self.userDefaultsManager = userDefaultsManager
            self.keychainStore = keychainStore
        }
    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func didLoad() {
        let userDefaultsIsClean: Bool? = userDefaultsManager.get(UserDefaultsManager.Keys.userDefaultsIsClean.rawValue)

        if userDefaultsIsClean == nil {
            keychainStore.clear()
            userDefaultsManager.set(false, key: UserDefaultsManager.Keys.userDefaultsIsClean.rawValue)
        }
    }

    func requestMainAuthFlow() {
        router.showMainAuthFlow()
    }
}

extension Presenter: Module.InteractorOutput { }
