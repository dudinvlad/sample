//
//  ApiRequestInterceptor.swift
//  TestSdk
//
//  Created by Vladislav Dudin on 19.11.2021.
//

import Alamofire
import Sentry

class ApiRequestInterceptor: RequestInterceptor {
    let retryLimit = 3
    let retryDelay: TimeInterval = 2
    var isRetrying = false

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print(urlRequest)
        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        let response = request.task?.response as? HTTPURLResponse
        if request.retryCount < self.retryLimit {
            if !isRetrying {
                self.isRetrying = true
                self.determineError(error: error, completion: completion)
            } else {
                completion(.retryWithDelay(self.retryDelay))
            }
        } else {
            SentrySDK.capture(error: error)
            completion(.doNotRetry)
        }
    }

    private func determineError(error: Error, completion: @escaping (RetryResult) -> Void) {
        if let afError = error as? AFError {
            switch afError {
            case .responseValidationFailed(let reason):
                self.determineResponseValidationFailed(reason: reason, completion: completion)
            default:
                self.isRetrying = false
                completion(.retryWithDelay(self.retryDelay))
            }
        }
    }

    private func determineResponseValidationFailed(reason: AFError.ResponseValidationFailureReason, completion: @escaping (RetryResult) -> Void) {
        switch reason {
        case .unacceptableStatusCode(let code):
            print(code)
            self.isRetrying = false
            completion(.retryWithDelay(self.retryDelay))
        default:
            self.isRetrying = false
            completion(.retryWithDelay(self.retryDelay))
        }
    }
}
