//
//  ReceiptService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 12.11.2021.
//

import Foundation

protocol ReceiptService {
    func validate(_ receipt: String, _ completion: @escaping (Bool?, String?) -> Void)
}
