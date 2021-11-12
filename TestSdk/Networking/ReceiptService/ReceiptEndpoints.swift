//
//  ReceiptEndpoints.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 12.11.2021.
//

import Alamofire

enum ReceiptEndpoints: EndpointType {
    case validate(_ receipt: String)

    var endpointPath: String {
        switch self {
            case .validate:
                return "/validateReceipt"
        }
    }

    var baseUrl: String {
        ApiUrlsPath.clientWebApi.rawValue
    }

    var url: String {
        baseUrl + endpointPath
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .validate:
            return .post
        }
    }

    var headers: HTTPHeaders {
        return ["x-access-token": "7e7c3f66-7aa8-4707-89c8-7f8071b478a2"]
    }

    var params: Parameters {
        switch self {
        case .validate(let receipt):
            return ["receipt": receipt,
                    "platform": "ios"]
        }
    }
}
