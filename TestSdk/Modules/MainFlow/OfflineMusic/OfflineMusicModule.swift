//
//  OfflineMusicModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 10.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct OfflineMusicModule {
    typealias ModuleAssemblying = OfflineMusicAssemblyProtocol
    typealias ViewInput         = OfflineMusicViewInputProtocol
    typealias ViewOutput        = OfflineMusicViewOutputProtocol
    typealias InteractorInput   = OfflineMusicInteractorInputProtocol
    typealias InteractorOutput  = OfflineMusicInteractorOutputProtocol
    typealias RouterInput       = OfflineMusicRouterInputProtocol
}

// MARK: - Assembly

protocol OfflineMusicAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol OfflineMusicViewInputProtocol: BaseViewInput {
    func update(with soundtracks: [Soundtrackable])
}

protocol OfflineMusicViewOutputProtocol: BaseViewOutput {
    func saveSelectedTrack(_ track: Soundtrackable)
    func requestDefaultTracks()
}

// MARK: - Interactor

protocol OfflineMusicInteractorInputProtocol {
    func fetchDefaultsTracks()
}

protocol OfflineMusicInteractorOutputProtocol: BaseInteractorOutput {
    func successDefaultsTracks(_ items: [Soundtrackable]?)
}

// MARK: - Router

protocol OfflineMusicRouterInputProtocol {
    func showRootMusicScreen()
}
