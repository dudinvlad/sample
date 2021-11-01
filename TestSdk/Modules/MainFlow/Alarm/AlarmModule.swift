//
//  AlarmModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct AlarmModule {
    typealias ModuleAssemblying = AlarmAssemblyProtocol
    typealias ViewInput         = AlarmViewInputProtocol
    typealias ViewOutput        = AlarmViewOutputProtocol
    typealias InteractorInput   = AlarmInteractorInputProtocol
    typealias InteractorOutput  = AlarmInteractorOutputProtocol
    typealias RouterInput       = AlarmRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol AlarmAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol AlarmViewInputProtocol: AnyObject { }

protocol AlarmViewOutputProtocol: BaseViewOutput {
    func presentSubscriptionsModule()
}

// MARK: - Interactor

protocol AlarmInteractorInputProtocol { }

protocol AlarmInteractorOutputProtocol: AnyObject {}

// MARK: - Router

protocol AlarmRouterInputProtocol {
    func presentSubscriptionsModule()
}
