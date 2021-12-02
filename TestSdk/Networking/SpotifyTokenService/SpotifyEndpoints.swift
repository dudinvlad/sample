//
//  SpotifyEndpoints.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Alamofire

enum SpotifyEndpoints: EndpointType {
    case authorize
    case accessToken(_ code: String)
    case savedTracks(_ offset: Int)
    case devices
    case startPlayer(_ deviceId: String, _ uri: String)
    case pausePlayer(_ deviceId: String)
    case searchTracks(_ query: String, _ offset: Int)

    var endpointPath: String {
        switch self {
        case .authorize: return "/authorize"
            case .accessToken: return  "/authorize"//"/api/token"
            case .savedTracks: return "/v1/me/tracks"
            case .devices: return "/v1/me/player/devices"
            case .startPlayer: return "/v1/me/player/play"
            case .pausePlayer: return "/v1/me/player/pause"
            case .searchTracks: return "/v1/search"
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .accessToken, .devices, .savedTracks, .searchTracks, .authorize:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var baseUrl: String {
        switch self {
        case .accessToken, .authorize:
            return ApiUrlsPath.spotifyToken.rawValue
        case .savedTracks, .devices, .startPlayer, .pausePlayer, .searchTracks:
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
//        case .searchTracks(let query, let offset):
//            fullUrl += "?q=\(query)&type=track&limit=50&offset=\(offset)"
        default:
            break
        }
        return fullUrl
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .accessToken:
            return .get
        case .savedTracks, .devices, .searchTracks, .authorize:
            return .get
        case .startPlayer, .pausePlayer:
            return .put
        }
    }

    var headers: HTTPHeaders {
        switch self {
//        case .accessToken:
//            return createSpotifyHeaders()
        case .savedTracks, .devices, .startPlayer, .pausePlayer, .searchTracks:
            let accessToken: String = KeychainStore().get(KeychainStore.KeychainKeys.spotifyToken.rawValue) ?? ""
            return ["Authorization": "Bearer \(accessToken)",
                    "Content-Type": "application/json"]
        case .accessToken, .authorize:
            return ["Content-Type": "application/json"]
        }
    }

    var params: Parameters {
        switch self {
            case .accessToken(let code):
                return createSpotifyParameters(with: code)
        case .authorize:
            return ["client_id": SpotifyConstants.spotifyClientID.rawValue,
                    "response_type": "code",
                    "redirect_uri": SpotifyConstants.spotifyRedirectUrl.rawValue]
            case .startPlayer(_, let uri):
            return ["context_uri": uri,
                    "position_ms": 0]
            case .savedTracks(let offset):
            return ["offset": offset]
        case .searchTracks(let query, let offset):
            return ["limit": 50,
                    "offset": offset,
                    "type": "track",
                    "q": query]
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
        return ["client_id": SpotifyConstants.spotifyClientID.rawValue,
                "scope": "user-library-read",
                "response_type": "code",
                "redirect_uri": SpotifyConstants.spotifyRedirectUrl.rawValue]
    }
}

