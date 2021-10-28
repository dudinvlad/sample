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

        required init(
            authService: AuthService
        ) {
            self.authService = authService
        }

    }
}

extension Interactor: Module.InteractorInput {
    func login(_ email: String, _ password: String) {
        authService.login(email: email, password: password) { [weak self] responseUser in
            self?.output.successLogin(by: responseUser)
        } failure: { [weak self] error in
            self?.output.failureNetworking(text: error)
        }

    }

    func signup(_ email: String, _ password: String, completion: @escaping (Result<AMUser, AMError>) -> Void) {
        authService.signup(email: email, password: password) { user in
            completion(.success(user))
        } failure: { [weak self] error in
            self?.output.failureNetworking(text: error)
        }
    }
}
