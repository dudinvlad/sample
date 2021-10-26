//
//  User.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation
import FirebaseAuth

struct AMUser: Encodable {
    let id: String
    var name: String
    var email: String
    var phone: String
    var sex: String

    init(by userData: User) {
        self.id = userData.uid
        self.name = userData.displayName ?? ""
        self.email = userData.email ?? ""
        self.phone = userData.phoneNumber ?? ""
        self.sex = ""
    }

    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "email": email,
            "phone": phone,
            "sex": sex
        ]
    }
}
