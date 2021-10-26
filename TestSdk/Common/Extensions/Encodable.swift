//
//  Encodable.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 24.10.2021.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> Any {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
