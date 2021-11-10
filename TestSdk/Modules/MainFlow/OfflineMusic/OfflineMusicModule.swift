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
    func assemble(_ items: [SpotifyTrack]) -> UIViewController
}

// MARK: - View
protocol OfflineMusicViewInputProtocol: BaseViewInput { }

protocol OfflineMusicViewOutputProtocol: BaseViewOutput {
    func saveSelectedTrack(_ track: SpotifyTrack)
}

// MARK: - Interactor

protocol OfflineMusicInteractorInputProtocol { }

protocol OfflineMusicInteractorOutputProtocol: BaseInteractorOutput { }

// MARK: - Router

protocol OfflineMusicRouterInputProtocol {
    func showRootMusicScreen()
}
