//
//  NetworkRequest.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya

struct Network {
    typealias DecodingData<T> = (type: T.Type, decoder: JSONDecoder)
    static var provider = MoyaProvider<API>()
    
    static func request(
        _ target: API,
        success successCallback: @escaping () -> Void,
        error errorCallback: @escaping (_ statusCode: HTTPStatusCode) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable {
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { _ in
        }, completion: { result in
            completionCallback()
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if statusCode.isSuccess {
                    successCallback()
                }
                else {
                    errorCallback(statusCode)
                }
            case let .failure(error):
                failureCallback(error)
            }
        })
        
        return cancellableRequest
    }
    
    @discardableResult
    static func request<T>(
        _ target: API,
        decodeType type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: T) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable where T: Decodable {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        
        let cancellableRequest = provider.request(target) { result in
            completionCallback()
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let result = try decoder.decode(T.self, from: response.data)
                    successCallback(result)
                }
                catch let e {
                    print(e)
                    errorCallback("Parsing error")
                }
            case let .failure(error):
//                if Date().timeIntervalSince(lastErrorThrowTime) >= 15 {
//                    lastErrorThrowTime = Date()
//                    SharezieToaster.shared.showToast(with: .failure, message: L10n.apiNetworkErrorMessage)
//                }
                failureCallback(error)
            }
        }
        
        return cancellableRequest
    }
}
