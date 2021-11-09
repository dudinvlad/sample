//
//  SpotifyService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Foundation

typealias SavedTrackCompletion = (SavedTracksResponseModel, ApiManager.NetworkError?) -> Void

protocol SpotifyService {
    func exchangeAccessToken(
        with code: String,
        _ completion: @escaping (String, ApiManager.NetworkError?) -> Void
    )

    func loadSavedTracks(offset: Int, _ completion: @escaping SavedTrackCompletion)
    func getAvailableDevices(_ completion: @escaping ([SpotifyDevice], ApiManager.NetworkError?) -> Void)
}
