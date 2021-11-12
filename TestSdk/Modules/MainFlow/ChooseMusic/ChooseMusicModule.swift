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
    func assemble(with complition: (() -> Void)?) -> UIViewController
}

// MARK: - View
protocol ChooseMusicViewInputProtocol: BaseViewInput {
    func update(with tracks: [Soundtrackable])
}

protocol ChooseMusicViewOutputProtocol: BaseViewOutput {
    func showChooseSource()
    func requestSavedTracks()
    func saveSelectedTrack(_ item: Soundtrackable)
    func trackDidSelect()
}

// MARK: - Interactor

protocol ChooseMusicInteractorInputProtocol {
    func fetchSavedTracks()
}

protocol ChooseMusicInteractorOutputProtocol: BaseInteractorOutput {
    func success(with tracks: [Soundtrackable])
}

// MARK: - Router

protocol ChooseMusicRouterInputProtocol {
    func showChooseSourceModule()
    func dismissChooseFlow()
}
