//
//  EndpointType.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Alamofire
import Foundation

enum ApiUrlsPath: String {
    case spotifyToken = "https://accounts.spotify.com"
    case spotifyWebApi = "https://api.spotify.com"
    case clientWebApi = "https://sdk-spotify.dev.dnc.pp.ua/api"
}

protocol EndpointType {
    var baseUrl: String { get }
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var params: Parameters { get }
    var data: Data? { get }
    var encoding: ParameterEncoding { get }
}

extension EndpointType {
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        return headers
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var data: Data? {
        nil
    }
}

