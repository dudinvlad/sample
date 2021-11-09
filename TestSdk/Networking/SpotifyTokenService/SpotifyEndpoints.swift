//
//  SpotifyEndpoints.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Alamofire

enum SpotifyEndpoints: EndpointType {
    case accessToken(_ code: String)
    case savedTracks(_ offset: Int)
    case devices
    case startPlayer(_ deviceId: String, _ uri: String)
    case pausePlayer(_ deviceId: String)

    var endpointPath: String {
        switch self {
            case .accessToken: return "/api/token"
            case .savedTracks: return "/v1/me/tracks"
            case .devices: return "/v1/me/player/devices"
            case .startPlayer: return "/v1/me/player/play"
            case .pausePlayer: return "/v1/me/player/pause"
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .accessToken, .devices, .savedTracks:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var baseUrl: String {
        switch self {
        case .accessToken:
            return ApiUrlsPath.spotifyToken.rawValue
        case .savedTracks, .devices, .startPlayer, .pausePlayer:
            return ApiUrlsPath.spotifyWebApi.rawValue
        }
    }

    var url: String {
        var fullUrl = baseUrl + endpointPath
        switch self {
        case .pausePlayer(let id):
            fullUrl += "?device_id=\(id)"
        case .startPlayer(let id, _):
            fullUrl += "?device_id=\(id)"
        default:
            break
        }
        return fullUrl
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .accessToken:
            return .post
        case .savedTracks, .devices:
            return .get
        case .startPlayer, .pausePlayer:
            return .put
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .accessToken:
            return createSpotifyHeaders()
        case .savedTracks, .devices, .startPlayer, .pausePlayer:
            let accessToken: String = KeychainStore().get("spotify_access_token") ?? ""
            return ["Authorization": "Bearer \(accessToken)",
                    "Content-Type": "application/json"]
        }
    }

    var params: Parameters {
        switch self {
            case .accessToken(let code):
                return createSpotifyParameters(with: code)
            case .startPlayer(_, let uri):
            return ["context_uri": uri,
                    "position_ms": 0]
            case .savedTracks(let offset):
            return ["offset": offset]
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

