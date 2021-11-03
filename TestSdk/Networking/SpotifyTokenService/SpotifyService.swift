//
//  SpotifyService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Foundation

protocol SpotifyService {
    func exchangeAccessToken(
        with code: String,
        _ completion: @escaping (String, ApiManager.NetworkError?) -> Void
    )

    func loadSavedTracks(_ completion: @escaping ([SpotifyTrack], ApiManager.NetworkError?) -> Void)
}
