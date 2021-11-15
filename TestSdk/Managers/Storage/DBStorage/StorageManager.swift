//
//  StorageManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation
import FirebaseDatabase

struct StorageManager: StorageService, SoundtrackStoreService {
    // MARK: - Variables
    private let dataBaseReference = Database.database().reference(withPath: "users")
    private let tracksBaseReference = Database.database().reference(withPath: "saved_tracks")
    private let subscriptionBaseReference = Database.database().reference(withPath: "subscriptions")
    private let tracksOfflineBaseReference = Database.database().reference(withPath: "saved_tracks_offline")

    private let keychain: StoreProtocol

    // MARK: - Init

    init(_ storage: StoreProtocol) {
        self.keychain = storage
    }
    // MARK: - Public

    func saveUserInfo(_ object: AMUser) {
        let userObjectReference = dataBaseReference.child(object.id)
        userObjectReference.setValue(object.toAnyObject())
    }

    func saveTracks(_ items: [Soundtrackable]) {
        guard !getCurrentUserId().isEmpty else { return }

        items.forEach { track in
            let trackObjectReference = tracksBaseReference.child(getCurrentUserId()).child(track.id)
            trackObjectReference.setValue(track.toAnyObject())
        }
    }

    func saveSubscriptionReceipt(_ receipt: String) {
        let subscriptionObjectReference = subscriptionBaseReference.child(getCurrentUserId())
        subscriptionObjectReference.setValue(receipt)
    }

    func getSubscriptionReceipt(_ completion: @escaping (String) -> Void) {
        guard !getCurrentUserId().isEmpty else { return }

        subscriptionBaseReference.child(getCurrentUserId()).getData { error, snapshot in
            guard let receiptData = snapshot.value as? String else { return }

            completion(receiptData)
        }
    }

    func getCurrentUser(completion: @escaping (AMUser?) -> Void) {
        guard !getCurrentUserId().isEmpty else { return }
        
        dataBaseReference.child(getCurrentUserId()).getData { error, snapshot in
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

    func getTracks(completion: @escaping ([Soundtrackable]) -> Void) {
        guard !getCurrentUserId().isEmpty else { return }

        tracksBaseReference.child(getCurrentUserId()).getData { error, snapshot in
            self.handlingTrackData(snapshot, completion: completion)
        }
    }

    // MARK: - Private

    private func getCurrentUserId() -> String {
        let currentUserId: String = keychain.get(KeychainStore.KeychainKeys.userUid.rawValue) ?? ""
        return currentUserId
    }

    private func handlingTrackData(_ snapshot: DataSnapshot, completion: @escaping ([Soundtrackable]) -> Void) {
        guard let tracksDict = snapshot.value as? [String: Any] else { return }
        let values = tracksDict.values.map {$0}

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: values)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedTracks = try decoder.decode([FirebaseSoundtrackParseModel].self, from: jsonData)
            DispatchQueue.main.async {
                completion(decodedTracks)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
