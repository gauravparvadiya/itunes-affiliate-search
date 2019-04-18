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
}
