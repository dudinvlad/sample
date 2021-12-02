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
    func exchangeAccessToken(with code: String, _ completion: @escaping (String?, String?) -> Void) {
        let request = SpotifyEndpoints.accessToken(code)

        apiManager.request(endoint: request) { (response: TokensResponseModel?, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let accessToken = response?.accessToken else { completion(nil, "No access token found"); return }

            completion(accessToken, nil)
        }
    }

    func loadSavedTracks(offset: Int = .zero, _ completion: @escaping SavedTrackCompletion) {
        let request = SpotifyEndpoints.savedTracks(offset)

        apiManager.request(endoint: request) { (response: SavedTracksResponseModel?, error) in
            completion(response, error)
        }
    }

    func searchTracks(with query: String, offset: Int, _ completion: @escaping (SearchTrackResponse?, String?) -> Void) {
        let request = SpotifyEndpoints.searchTracks(query, offset)

        apiManager.request(endoint: request) { (response: SearchTrackResponse?, error) in
            completion(response, error)
        }
    }
}
