//
//  WelcomeModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 21.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct WelcomeModule {
    typealias ModuleAssemblying = WelcomeAssemblyProtocol
    typealias ViewInput         = WelcomeViewInputProtocol
    typealias ViewOutput        = WelcomeViewOutputProtocol
    typealias InteractorInput   = WelcomeInteractorInputProtocol
    typealias InteractorOutput  = WelcomeInteractorOutputProtocol
    typealias RouterInput       = WelcomeRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol WelcomeAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol WelcomeViewInputProtocol: AnyObject { }

protocol WelcomeViewOutputProtocol: BaseViewOutput {
    func requestMainAuthFlow()
}

// MARK: - Interactor

protocol WelcomeInteractorInputProtocol { }

protocol WelcomeInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol WelcomeRouterInputProtocol {
    func showMainAuthFlow()
}
