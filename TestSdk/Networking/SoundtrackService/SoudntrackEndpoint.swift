//
//  SoudntrackEndpoint.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 11.11.2021.
//

import Alamofire

enum SoudntrackEndpoint: EndpointType {
    case getDefaultTracks

    var baseUrl: String {
        return ApiUrlsPath.clientWebApi.rawValue
    }

    var url: String {
        baseUrl + endpointPath
    }

    var endpointPath: String {
        switch self {
            case .getDefaultTracks: return "/alarmRingtones"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .getDefaultTracks: return .get
        }
    }

    var headers: HTTPHeaders {
        ["x-access-token": "7e7c3f66-7aa8-4707-89c8-7f8071b478a2"]
    }

    var encoding: ParameterEncoding {
        switch self {
            case .getDefaultTracks: return URLEncoding.default
        }
    }

    var params: Parameters {
        switch self {
        case .getDefaultTracks: return [:]
        }
    }

}
