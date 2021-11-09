//
//  ApiManager.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 03.11.2021.
//

import Alamofire
import Foundation

class ApiManager {
    typealias ResponseBlock<T: Codable> = (_ object: T?, _ error: String?) -> Void

    enum NetworkError: Error {
        case parsingError
        case serverError(description: String)
    }

    // MARK: - Variables

    lazy var session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        return Alamofire.Session(configuration: configuration, eventMonitors: [AlamofireLogger()])
    }()

    // MARK: - Public

    func request<T: Codable>(endoint: EndpointType, completion: @escaping ResponseBlock<T>) {
        session.request(
            endoint.url,
            method: endoint.httpMethod,
            parameters: endoint.params,
            encoding: endoint.encoding,
            headers: endoint.headers
        ).responseData { dataResponse in
            self.handleResponse(dataResponse, completion: completion)
        }
    }

    // MARK: - Private

    private func handleResponse<T: Codable>(_ response: AFDataResponse<Data>, completion: ResponseBlock<T>) {
        guard let data = response.data else { completion(nil, "Something went wrong!"); return }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            if let spotifyError = try? decoder.decode(SpotifyErrorResponse.self, from: data) {
                completion(nil, spotifyError.error.message)
            }

            let responseObject = try decoder.decode(T.self, from: data)

            if let error = response.error?.localizedDescription {
                completion(nil, error)
                return
            }

            completion(responseObject, nil)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error.localizedDescription)
        }
    }
}

final class AlamofireLogger: EventMonitor {
    func requestDidResume(_ request: Request) {

        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let headers = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Headers: \(allHeaders)
        """
        NSLog(headers)

        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Body Data: \(body)
        """
        NSLog(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {

        NSLog("⚡️⚡️⚡️⚡️ Response Received: \(response.debugDescription)")
        NSLog("⚡️⚡️⚡️⚡️ Response All Headers: \(String(describing: response.response?.allHeaderFields))")
    }
}
