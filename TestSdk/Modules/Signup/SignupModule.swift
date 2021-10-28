//
//  SignupModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SignupModule {
    typealias ModuleAssemblying = SignupAssemblyProtocol
    typealias ViewInput         = SignupViewInputProtocol
    typealias ViewOutput        = SignupViewOutputProtocol
    typealias InteractorInput   = SignupInteractorInputProtocol
    typealias InteractorOutput  = SignupInteractorOutputProtocol
    typealias RouterInput       = SignupRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol SignupAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol SignupViewInputProtocol: BaseViewInput { }

protocol SignupViewOutputProtocol: BaseViewOutput {
    func requestSignup(
        email: String,
        password: String,
        name: String,
        phone: String,
        sex: String
    )
}

// MARK: - Interactor

protocol SignupInteractorInputProtocol {
    func signup(
        _ email: String,
        _ password: String,
        completion: @escaping (Result<AMUser, AMError>) -> Void
    )
    func login(
        _ email: String,
        _ password: String
    )
}

protocol SignupInteractorOutputProtocol: BaseInteractorOutput {
    func successLogin(by user: AMUser)
}

// MARK: - Router

protocol SignupRouterInputProtocol {
    func showMainFlow()
}
