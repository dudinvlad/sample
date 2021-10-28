//
//  MainAuthModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 22.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MainAuthModule {
    typealias ModuleAssemblying = MainAuthAssemblyProtocol
    typealias ViewInput         = MainAuthViewInputProtocol
    typealias ViewOutput        = MainAuthViewOutputProtocol
    typealias InteractorInput   = MainAuthInteractorInputProtocol
    typealias InteractorOutput  = MainAuthInteractorOutputProtocol
    typealias RouterInput       = MainAuthRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol MainAuthAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol MainAuthViewInputProtocol: AnyObject { }

protocol MainAuthViewOutputProtocol: BaseViewOutput {
    func requestLoginFlow()
    func requestSignUpFlow()
}

// MARK: - Interactor

protocol MainAuthInteractorInputProtocol { }

protocol MainAuthInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol MainAuthRouterInputProtocol {
    func showLoginFlow()
    func showSignUpFlow()
    func showMainFlow()
}
