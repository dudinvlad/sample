//
//  RestSpotifyService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Foundation

struct RestSpotifyService: SpotifyService {
    // MARK: - Variables

    private let apiManager: ApiManager

    // MARK: - Init
    init(
        _ apiManager: ApiManager
    ) {
        self.apiManager = apiManager
    }
    func exchangeAccessToken(with code: String, _ completion: @escaping (String, ApiManager.NetworkError?) -> Void) {
        let request = SpotifyEndpoints.accessToken(code)

        apiManager.request(endoint: request) { (response: TokensResponseModel?, error) in
            guard let accessToken = response?.accessToken else { return }
            completion(accessToken, nil)
        }
    }

    func loadSavedTracks(_ completion: @escaping ([SpotifyTrack], ApiManager.NetworkError?) -> Void) {
        let request = SpotifyEndpoints.savedTracks

        apiManager.request(endoint: request) { (response: SavedTracksResponseModel?, error) in
            guard let responseItems = response?.items else { return }

            let responseTracks = responseItems.compactMap { $0.track }
            let tracksWithPreview = responseTracks.filter { $0.previewUrl != nil }
            completion(tracksWithPreview, nil)
        }
    }

    func getAvailableDevices(_ completion: @escaping ([SpotifyDevice], ApiManager.NetworkError?) -> Void) {
        let request = SpotifyEndpoints.devices

        apiManager.request(endoint: request) { (response: SpotifyDevicesResponse?, error) in
            guard let responseItems = response?.devices else { return }

            completion(responseItems, nil)
        }
    }

    func startPlayback(with deviceId: String, uri: String) {
        let request = SpotifyEndpoints.startPlayer(deviceId, uri)

        apiManager.request(endoint: request) { (response: String?, error) in
            print(error)
        }
    }
}
