//
//  StorageService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation

protocol StorageService {
    func saveUserInfo(_ object: AMUser)
}

enum UserDefaultsKey: String {
    case expiredPaymentDate = "expiredPaymentDate"
}
