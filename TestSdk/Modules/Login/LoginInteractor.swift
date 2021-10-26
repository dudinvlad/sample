//
//  LoginInteractor.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = LoginModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!
        private let authService: AuthService

        required init(authService: AuthService) {
            self.authService = authService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func login(email: String, password: String) {
        authService.login(email: email, password: password) { [weak self] _ in
            self?.output.successLogin()
            self?.output.infoNetworking(text: "show main flow soon")
        } failure: { [weak self] error in
            self?.output.failureNetworking(text: error)
        }
    }
}
