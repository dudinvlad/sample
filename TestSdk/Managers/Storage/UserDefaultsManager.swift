//
//  UserDefaultsManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 04.11.2021.
//

import Foundation

class UserDefaultsManager: StoreProtocol {
    enum Keys: String, CaseIterable {
        case selectedDate
        case selectedUri
        case deviceId
        case userDefaultsIsClean
    }

    private let userDefaults = UserDefaults.standard

    func set<T>(_ value: T?, key: String) where T : Encodable {
        userDefaults.set(value, forKey: key)
    }

    func get<T>(_ key: String) -> T? where T : Decodable {
        let value = userDefaults.value(forKey: key) as? T
        return value
    }

    func delete(by key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func clear() {
        Keys.allCases.forEach { userDefaults.removeObject(forKey: $0.rawValue) }
    }
}
