//
//  StorageService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation

protocol StorageService {
    func saveUserInfo(_ object: AMUser)
    func saveTracks(_ items: [SpotifyTrack])
    func getTracks(completion: @escaping ([SpotifyTrack]) -> Void)
    func getCurrentUser(completion: @escaping (AMUser?) -> Void)
}
