//
//  SignupInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = SignupModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!
        private let authService: AuthService
        private let storageService: StorageService

        required init(
            authService: AuthService,
            storageService: StorageService
        ) {
            self.authService = authService
            self.storageService = storageService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func signup(_ email: String, _ password: String, _ name: String, _ phone: String, _ sex: String) {
        authService.signup(email: email, password: password) { [weak self] user in
            var newUser = user
            newUser.name = name
            newUser.phone = phone
            newUser.sex = sex

            self?.storageService.saveUserInfo(newUser)
            self?.output.infoNetworking(text: "show main flow soon")
        } failure: { [weak self] error in
            self?.output.failureNetworking(text: error)
        }
    }
}
