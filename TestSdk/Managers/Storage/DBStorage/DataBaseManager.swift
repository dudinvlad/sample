//
//  DataBaseManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation
import FirebaseDatabase

struct DataBaseManager: StorageService {
    // MARK: - Variables
    private let dataBaseReference = Database.database().reference(withPath: "users")
    private let tracksBaseReference = Database.database().reference(withPath: "saved_tracks")

    // MARK: - Public

    func saveUserInfo(_ object: AMUser) {
        let userObjectReference = dataBaseReference.child(object.id)
        userObjectReference.setValue(object.toAnyObject())
    }

    func saveTracks(_ items: [SpotifyTrack]) {
        items.forEach { track in
            let trackObjectReference = tracksBaseReference.child(track.id)
            trackObjectReference.setValue(track.toAnyObject())
        }
    }

    func getCurrentUser(completion: @escaping (AMUser?) -> Void) {
        let currentUserId: String = KeychainStore().get(KeychainStore.KeychainKeys.userUid.rawValue) ?? ""
        guard !currentUserId.isEmpty else { return }
        
        dataBaseReference.child(currentUserId).getData { error, snapshot in
            guard let userDict = snapshot.value as? [String: Any] else { return }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: userDict)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedUser = try decoder.decode(AMUser.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(decodedUser)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func getTracks(completion: @escaping ([SpotifyTrack]) -> Void) {
        tracksBaseReference.getData { error, snapshot in
            guard let tracksDict = snapshot.value as? [String: Any] else { return }
            let values = tracksDict.values.map {$0}

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: values)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedTracks = try decoder.decode([SpotifyTrack].self, from: jsonData)
                DispatchQueue.main.async {
                    completion(decodedTracks)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
