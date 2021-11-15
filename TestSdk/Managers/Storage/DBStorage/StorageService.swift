//
//  StorageService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation

protocol StorageService {
    func saveUserInfo(_ object: AMUser)
    func getCurrentUser(completion: @escaping (AMUser?) -> Void)
    func saveSubscriptionReceipt(_ receipt: String)
    func getSubscriptionReceipt(_ completion: @escaping (String) -> Void)
}

protocol SoundtrackStoreService {
    func saveTracks(_ items: [Soundtrackable])
    func getTracks(completion: @escaping ([Soundtrackable]) -> Void)
}
