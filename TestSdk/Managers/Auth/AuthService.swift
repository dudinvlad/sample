//
//  AuthService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation

protocol AuthService {
    func signup(
        email: String,
        password: String,
        success: @escaping (AMUser) -> Void,
        failure: @escaping (String) -> Void
    )
    
    func login(
        email: String,
        password: String,
        success: @escaping (AMUser) -> Void,
        failure: @escaping (String) -> Void
    )
}
