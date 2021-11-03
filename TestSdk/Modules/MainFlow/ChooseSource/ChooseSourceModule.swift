//
//  ChooseSourceModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 03.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ChooseSourceModule {
    typealias ModuleAssemblying = ChooseSourceAssemblyProtocol
    typealias ViewInput         = ChooseSourceViewInputProtocol
    typealias ViewOutput        = ChooseSourceViewOutputProtocol
    typealias InteractorInput   = ChooseSourceInteractorInputProtocol
    typealias InteractorOutput  = ChooseSourceInteractorOutputProtocol
    typealias RouterInput       = ChooseSourceRouterInputProtocol
}

// MARK: - Assembly

protocol ChooseSourceAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol ChooseSourceViewInputProtocol: BaseViewInput { }

protocol ChooseSourceViewOutputProtocol: BaseViewOutput {
    func presentSubscriptionsModule()
    func requestSpotifyConnect()
}

// MARK: - Interactor

protocol ChooseSourceInteractorInputProtocol {
    func exchangeToken(with code: String)
    func fetchSavedTracks()
}

protocol ChooseSourceInteractorOutputProtocol: BaseInteractorOutput {
    func spotifySuccess(with accessToken: String)
    func success(with tracks: [SpotifyTrack])
}

// MARK: - Router

protocol ChooseSourceRouterInputProtocol {
    func presentSubscriptionsModule()
}
