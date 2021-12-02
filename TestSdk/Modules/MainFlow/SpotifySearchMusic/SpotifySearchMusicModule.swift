//
//  SpotifySearchMusicModule.swift
//  TestSdk
//
//  Created Vladislav Dudin on 16.11.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct SpotifySearchMusicModule {
    typealias ModuleAssemblying = SpotifySearchMusicAssemblyProtocol
    typealias ViewInput         = SpotifySearchMusicViewInputProtocol
    typealias ViewOutput        = SpotifySearchMusicViewOutputProtocol
    typealias InteractorInput   = SpotifySearchMusicInteractorInputProtocol
    typealias InteractorOutput  = SpotifySearchMusicInteractorOutputProtocol
    typealias RouterInput       = SpotifySearchMusicRouterInputProtocol
}

// MARK: - Assembly

protocol SpotifySearchMusicAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol SpotifySearchMusicViewInputProtocol: BaseViewInput {
    func updateTracks(with data: [SpotifyTrack])
}

protocol SpotifySearchMusicViewOutputProtocol: BaseViewOutput {
    func saveSelectedTrack(_ track: SpotifyTrack)
    func requestMoreSearchTracks()
    func requestSearch(_ query: String)
}

// MARK: - Interactor

protocol SpotifySearchMusicInteractorInputProtocol {
    func searchTracks(with query: String, offset: Int)
}

protocol SpotifySearchMusicInteractorOutputProtocol: BaseInteractorOutput {
    func success(with data: SearchTracksResponseModel?)
}

// MARK: - Router

protocol SpotifySearchMusicRouterInputProtocol {
    func showRootMusicScreen()
}
