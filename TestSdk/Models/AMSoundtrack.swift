//
//  AMSoundtrack.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 11.11.2021.
//

import Foundation

protocol Soundtrackable {
    var artistName: String { get set }
    var soundtrackName: String { get set }
    var soundtrackPath: String { get set }
    var fileName: String { get set }
    var id: String { get set }
    var isSpotify: Bool { get set }
    func toAnyObject() -> Any
}

struct FirebaseSoundtrackParseModel: Codable, Soundtrackable {
    var artistName: String
    var soundtrackName: String
    var soundtrackPath: String
    var fileName: String
    var id: String
    var isSpotify: Bool
    func toAnyObject() -> Any {
        Any.self
    }
}

struct SoundtrackResponse: Codable {
    let ringtones: [AMSoundtrack]
}

struct AMSoundtrack: Codable {
    var artist: String
    var name: String
    var file: String
    var url: String
}

extension AMSoundtrack: Soundtrackable {
    var artistName: String {
        set {
            artist = newValue
        }
        get {
            artist
        }
    }

    var soundtrackName: String {
        set {
            name = newValue
        }
        get {
            name
        }
    }
    var soundtrackPath: String {
        set {
            url = newValue
        }
        get {
            url
        }
    }
    var fileName: String {
        set {
            file = newValue
        }
        get {
            file
        }
    }
    var id: String {
        set { }
        get {
            UUID().uuidString
        }
    }
    var isSpotify: Bool {
        set { }

        get {
            false
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
