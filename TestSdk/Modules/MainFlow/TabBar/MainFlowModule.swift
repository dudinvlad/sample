//
//  MainFlowModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MainFlowModule {
    typealias ModuleAssemblying = MainFlowAssemblyProtocol
    typealias ViewInput         = MainFlowViewInputProtocol
    typealias ViewOutput        = MainFlowViewOutputProtocol
    typealias InteractorInput   = MainFlowInteractorInputProtocol
    typealias InteractorOutput  = MainFlowInteractorOutputProtocol
    typealias RouterInput       = MainFlowRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol MainFlowAssemblyProtocol {
    func assemble() -> UITabBarController
}

// MARK: - View
protocol MainFlowViewInputProtocol: AnyObject { }

protocol MainFlowViewOutputProtocol: BaseViewOutput {
}

// MARK: - Interactor

protocol MainFlowInteractorInputProtocol { }

protocol MainFlowInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol MainFlowRouterInputProtocol { }
