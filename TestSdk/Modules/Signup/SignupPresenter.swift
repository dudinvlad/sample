//
//  SignupPresenter.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SignupModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private let storageService: StorageService
        private let keychainService: StoreProtocol

        required init(
            storageService: StorageService,
            keychainService: StoreProtocol
        ) {
            self.storageService = storageService
            self.keychainService = keychainService
        }

    }
}

private extension Presenter {
}

extension Presenter: Module.ViewOutput {
    func requestSignup(email: String, password: String, name: String, phone: String, sex: String) {
        interactor.signup(email, password) { [weak self] result in
            switch result {
            case .success(var user):
                user.name = name
                user.phone = phone
                user.sex = sex
                self?.storageService.saveUserInfo(user)
                self?.interactor.login(email, password)
            default:
                return
            }
        }
    }
}

extension Presenter: Module.InteractorOutput {
    func successLogin(by user: AMUser) {
        keychainService.set(
            user.id,
            key: KeychainStore.KeychainKeys.userUid.rawValue
        )
        router.showMainFlow()
    }

    var controller: BaseViewInput? {
        return view
    }
}
