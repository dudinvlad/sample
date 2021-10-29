//
//  AboutUsModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct AboutUsModule {
    typealias ModuleAssemblying = AboutUsAssemblyProtocol
    typealias ViewInput         = AboutUsViewInputProtocol
    typealias ViewOutput        = AboutUsViewOutputProtocol
    typealias InteractorInput   = AboutUsInteractorInputProtocol
    typealias InteractorOutput  = AboutUsInteractorOutputProtocol
    typealias RouterInput       = AboutUsRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol AboutUsAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol AboutUsViewInputProtocol: AnyObject { }

protocol AboutUsViewOutputProtocol: BaseViewOutput { }

// MARK: - Interactor

protocol AboutUsInteractorInputProtocol { }

protocol AboutUsInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol AboutUsRouterInputProtocol { }
