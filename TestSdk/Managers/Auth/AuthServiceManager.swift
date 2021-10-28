//
//  AuthServiceManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation
import FirebaseAuth

struct AuthServiceManager: AuthService {
    enum AuthKeys: String {
        case userUid
    }

    // MARK: - Init

    func signup(email: String, password: String, success: @escaping (AMUser) -> Void, failure: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription {
                failure(error)
                return
            }
            if let user = result?.user {
                success(.init(by: user))
            }
        }
    }

    func login(email: String, password: String, success: @escaping (AMUser) -> Void, failure: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription {
                failure(error)
                return
            }
            if let user = result?.user {
                success(.init(by: user))
            }
        }
    }
}
