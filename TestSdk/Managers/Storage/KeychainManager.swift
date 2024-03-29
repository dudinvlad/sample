//
//  KeychainManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 28.10.2021.
//

import KeychainAccess

protocol StoreProtocol: AnyObject {
    func get<T: Decodable>(_ key: String) -> T?
    func set<T: Encodable>(_ value: T?, key: String)
    func delete(by key: String)
    func clear()
}

class KeychainStore: StoreProtocol {
    enum KeychainKeys: String {
        case userUid
        case spotifyToken = "spotify_access_token"
    }
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    func get<T>(_ key: String) -> T? where T: Decodable {
        do {
            guard let data = try keychain.getData(key) else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    func set<T>(_ value: T?, key: String) where T: Encodable {
        guard let value = value else { return }

        do {
            let data = try JSONEncoder().encode(value)

            try keychain.set(data, key: key)
        } catch let error {
            debugPrint("‼️ Error set to 🔑: \(error.localizedDescription)")
        }
    }

    func delete(by key: String) {
        do {
            try keychain.remove(key)
        } catch let error {
            debugPrint("‼️ Error delete: \(error.localizedDescription)")
        }
    }

    func clear() {
        do {
            try keychain.removeAll()
        } catch let error {
            debugPrint("‼️ Error clear: \(error.localizedDescription)")
        }
    }
}
