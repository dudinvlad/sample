//
//  ChooseMusicModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ChooseMusicModule {
    typealias ModuleAssemblying = ChooseMusicAssemblyProtocol
    typealias ViewInput         = ChooseMusicViewInputProtocol
    typealias ViewOutput        = ChooseMusicViewOutputProtocol
    typealias InteractorInput   = ChooseMusicInteractorInputProtocol
    typealias InteractorOutput  = ChooseMusicInteractorOutputProtocol
    typealias RouterInput       = ChooseMusicRouterInputProtocol

//    enum Localize: String, Localizable {
//        case test
//    }
}

// MARK: - Assembly

protocol ChooseMusicAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol ChooseMusicViewInputProtocol: BaseViewInput { }

protocol ChooseMusicViewOutputProtocol: BaseViewOutput {
    func showChooseSource()
}

// MARK: - Interactor

protocol ChooseMusicInteractorInputProtocol { }

protocol ChooseMusicInteractorOutputProtocol: BaseInteractorOutput { }

// MARK: - Router

protocol ChooseMusicRouterInputProtocol {
    func showChooseSourceModule()
}
