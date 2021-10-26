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

    // MARK: - Public

    func saveUserInfo(_ object: AMUser) {
        let userObjectReference = dataBaseReference.child(object.name)
        userObjectReference.setValue(object.toAnyObject())
    }
}
