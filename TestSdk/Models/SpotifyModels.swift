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
    let total: Int
    let offset: Int
    let limit: Int

}

struct SpotifyTrackResponse: Codable {
    let track: SpotifyTrack
}

struct SpotifyTrack: Codable {
    var id: String
    let name: String
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
    let uri: String
    var previewUrl: String?
    var isSpotify: Bool = true

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case album
        case uri
        case previewUrl
    }
}

extension SpotifyTrack: Soundtrackable {
    var artistName: String {
        set{ }
        get {
            artists.first?.name ?? ""
        }
    }
    var soundtrackName: String {
        set{ }
        get {
            name
        }
    }
    var soundtrackPath: String {
        set{ }
        get {
            previewUrl ?? ""
        }
    }
    var fileName: String {
        set{ }
        get {
            name.appending(".mp3")
        }
    }

    func toAnyObject() -> Any {
        return ["id": id,
                "soundtrack_name": soundtrackName,
                "soundtrack_path": soundtrackPath,
                "file_name": fileName,
                "artist_name": artistName,
                "is_spotify": isSpotify]
    }
}

struct SpotifyAlbum: Codable {
    let images: [SpotifyAlbumImage]

    func toAnyObject() -> Any {
        return ["images": images.toAny()]
    }
}

struct SpotifyAlbumImage: Codable {
    let height: Int
    let width: Int
    let url: String

    func toAnyObject() -> Any {
        return ["url": url,
                "width": width,
                "height": height]
    }
}

struct SpotifyArtist: Codable {
    let id: String
    let uri: String
    let name: String

    func toAnyObject() -> Any {
        return ["id": id,
                "uri": uri,
                "name": name]
    }
}

struct SpotifyDevicesResponse: Codable {
    let devices: [SpotifyDevice]
}

struct SpotifyDevice: Codable {
    let id: String
    let name: String
    let type: String
}

class SpotifyErrorResponse: Codable {
    let error: SpotifyError
}

class SpotifyError: Codable {
    let status: Int
    let message: String
}

class ApiError: Codable {
    let message: String
    let statusCode: Int
}
