//
//  LoginModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 23.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct LoginModule {
    typealias ModuleAssemblying = LoginAssemblyProtocol
    typealias ViewInput         = LoginViewInputProtocol
    typealias ViewOutput        = LoginViewOutputProtocol
    typealias InteractorInput   = LoginInteractorInputProtocol
    typealias InteractorOutput  = LoginInteractorOutputProtocol
    typealias RouterInput       = LoginRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol LoginAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol LoginViewInputProtocol: BaseViewInput {
}

protocol LoginViewOutputProtocol: BaseViewOutput {
    func requestLogin(with email: String, password: String)
}

// MARK: - Interactor

protocol LoginInteractorInputProtocol {
    func login(email: String, password: String)
}

protocol LoginInteractorOutputProtocol: BaseInteractorOutput {
    func successLogin()
}

// MARK: - Router

protocol LoginRouterInputProtocol {
    func showMainFlow()
}
