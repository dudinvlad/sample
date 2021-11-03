//
//  SpotifyModels.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Foundation

struct TokensResponseModel: Codable {
    let accessToken: String
}

struct SavedTracksResponseModel: Codable {
    let items: [SpotifyTrackResponse]
}

struct SpotifyTrackResponse: Codable {
    let track: SpotifyTrack
}

struct SpotifyTrack: Codable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
    let uri: String
}

struct SpotifyArtist: Codable {
    let id: String
    let uri: String
    let name: String
}
