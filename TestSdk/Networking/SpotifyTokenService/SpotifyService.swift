//
//  SpotifyService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Foundation

typealias SavedTrackCompletion = (SavedTracksResponseModel?, String?) -> Void

protocol SpotifyService {
    func exchangeAccessToken(
        with code: String,
        _ completion: @escaping (String?, String?) -> Void
    )
    func loadSavedTracks(offset: Int, _ completion: @escaping SavedTrackCompletion)
    func searchTracks(with query: String, offset: Int, _ completion: @escaping (SearchTrackResponse?, String?) -> Void)
}
