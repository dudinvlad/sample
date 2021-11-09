//
//  Array.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 07.11.2021.
//

import Foundation

extension Array where Element == SpotifyArtist {
    func toAny() -> [Any] {
        return map { $0.toAnyObject() }
    }
}

extension Array where Element == SpotifyAlbumImage {
    func toAny() -> [Any] {
        return map { $0.toAnyObject() }
    }
}
