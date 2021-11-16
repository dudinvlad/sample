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
//    func assemble(_ inputData: SavedTracksResponseModel?) -> UIViewController
    func assemble() -> UIViewController
}

// MARK: - View
protocol SpotifyMusicViewInputProtocol: BaseViewInput {
    func updateTracks(with data: [SpotifyTrack])
}

protocol SpotifyMusicViewOutputProtocol: BaseViewOutput {
    func saveSelectedTrack(_ track: SpotifyTrack)
//    func requestMoreSaveTrack()
    func requestMoreSearchTracks()
    func requestSearch(_ query: String)
}

// MARK: - Interactor

protocol SpotifyMusicInteractorInputProtocol {
//    func fetchSavedTracks(with offset: Int)
    func searchTracks(with query: String, offset: Int)
}

protocol SpotifyMusicInteractorOutputProtocol: BaseInteractorOutput {
    func success(with data: SearchTracksResponseModel?)
}

// MARK: - Router

protocol SpotifyMusicRouterInputProtocol {
    func showRootMusicScreen()
}
