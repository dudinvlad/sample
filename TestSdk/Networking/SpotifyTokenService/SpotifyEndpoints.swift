//
//  SpotifyEndpoints.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Alamofire

enum SpotifyEndpoints: EndpointType {
    case accessToken(_ code: String)
    case savedTracks

    var endpointPath: String {
        switch self {
            case .accessToken: return "/api/token"
            case .savedTracks: return "/v1/me/tracks"
        }
    }

    var baseUrl: String {
        switch self {
        case .accessToken:
            return ApiUrlsPath.spotifyToken.rawValue
        case .savedTracks:
            return ApiUrlsPath.spotifyWebApi.rawValue
        }
    }

    var url: String {
        baseUrl + endpointPath
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .accessToken:
            return .post
        case .savedTracks:
            return .get
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .accessToken:
            return createSpotifyHeaders()
        case .savedTracks:
            let accessToken: String = KeychainStore().get("spotify_access_token") ?? ""
            return ["Authorization": "Bearer \(accessToken)",
                    "Content-Type": "application/json"]
        }
    }

    var params: Parameters {
        switch self {
            case .accessToken(let code):
                return createSpotifyParameters(with: code)
            default:
                return [:]
        }
    }

    // MARK: - Private

    private func createSpotifyHeaders() -> HTTPHeaders {
        guard let authKeyData = (SpotifyConstants.spotifyClientID.rawValue + ":" + SpotifyConstants.spotifyClientSecret.rawValue).data(using: .utf8) else { return [:] }

        let spotifyAuthKey = "Basic \(authKeyData.base64EncodedString())"

        return ["Authorization": spotifyAuthKey, "Content-Type": "application/x-www-form-urlencoded"]
    }

    private func createSpotifyParameters(with code: String) -> Parameters {
        return ["code": code,
                "grant_type": "authorization_code",
                "redirect_uri": SpotifyConstants.spotifyRedirectUrl.rawValue]
    }
}

