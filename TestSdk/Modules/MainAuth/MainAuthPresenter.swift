//
//  MainAuthPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = MainAuthModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let keychainService: StoreProtocol

        required init(
            keychainService: StoreProtocol
        ) {
            self.keychainService = keychainService
        }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func requestLoginFlow() {
        router.showLoginFlow()
    }

    func requestSignUpFlow() {
        router.showSignUpFlow()
    }
}

extension Presenter: Module.InteractorOutput {
    func didLoad() {
        guard
            let userUid: String? = keychainService.get(KeychainStore.KeychainKeys.userUid.rawValue),
            userUid != nil
        else { return }

        router.showMainFlow()
    }
}
