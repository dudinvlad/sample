//
//  RestReceiptService.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 12.11.2021.
//

import Foundation

struct RestReceiptService: ReceiptService {
    // MARK: - Variables

    private let apiManager: ApiManager

    // MARK: - Init
    init(
        _ apiManager: ApiManager
    ) {
        self.apiManager = apiManager
    }

    func validate(_ receipt: String, _ completion: @escaping (Bool?, String?) -> Void) {
        let request = ReceiptEndpoints.validate(receipt)

        apiManager.request(endoint: request) { (response: ReceiptValifationModel?, error) in
            completion(response?.valid, error)
        }
    }
}
