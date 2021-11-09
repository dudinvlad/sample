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

    func loadSavedTracks(offset: Int = .zero, _ completion: @escaping SavedTrackCompletion) {
        let request = SpotifyEndpoints.savedTracks(offset)

        apiManager.request(endoint: request) { (response: SavedTracksResponseModel?, error) in
            guard
                let responseItem = response
            else { return }

            completion(responseItem, nil)
        }
    }

    func getAvailableDevices(_ completion: @escaping ([SpotifyDevice], ApiManager.NetworkError?) -> Void) {
        let request = SpotifyEndpoints.devices

        apiManager.request(endoint: request) { (response: SpotifyDevicesResponse?, error) in
            guard let responseItems = response?.devices else { return }

            completion(responseItems, nil)
        }
    }
}
