//
//  SpotifyMusicModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 07.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SpotifyMusicModule {
    typealias ModuleAssemblying = SpotifyMusicAssemblyProtocol
    typealias ViewInput         = SpotifyMusicViewInputProtocol
    typealias ViewOutput        = SpotifyMusicViewOutputProtocol
    typealias InteractorInput   = SpotifyMusicInteractorInputProtocol
    typealias InteractorOutput  = SpotifyMusicInteractorOutputProtocol
    typealias RouterInput       = SpotifyMusicRouterInputProtocol
}

// MARK: - Assembly

protocol SpotifyMusicAssemblyProtocol {
    func assemble(_ tracks: [SpotifyTrack]) -> UIViewController
}

// MARK: - View
protocol SpotifyMusicViewInputProtocol: BaseViewInput { }

protocol SpotifyMusicViewOutputProtocol: BaseViewOutput {
    func saveSelectedTrack(_ track: SpotifyTrack)
}

// MARK: - Interactor

protocol SpotifyMusicInteractorInputProtocol { }

protocol SpotifyMusicInteractorOutputProtocol: BaseInteractorOutput { }

// MARK: - Router

protocol SpotifyMusicRouterInputProtocol {
    func showRootMusicScreen()
}
