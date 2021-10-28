//
//  SpotifyModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SpotifyModule {
    typealias ModuleAssemblying = SpotifyAssemblyProtocol
    typealias ViewInput         = SpotifyViewInputProtocol
    typealias ViewOutput        = SpotifyViewOutputProtocol
    typealias InteractorInput   = SpotifyInteractorInputProtocol
    typealias InteractorOutput  = SpotifyInteractorOutputProtocol
    typealias RouterInput       = SpotifyRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol SpotifyAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol SpotifyViewInputProtocol: AnyObject { }

protocol SpotifyViewOutputProtocol: BaseViewOutput { }

// MARK: - Interactor

protocol SpotifyInteractorInputProtocol { }

protocol SpotifyInteractorOutputProtocol: AnyObject { }

// MARK: - Router

protocol SpotifyRouterInputProtocol { }
