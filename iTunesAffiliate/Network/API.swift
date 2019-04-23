//
//  API.swift
//  iTunesAffiliate
//
//  Created by Gaurav Parvadiya on 2019-04-17.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum API {
    // POST
    case fetchAlbum(text: String)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .fetchAlbum:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchAlbum:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var parameters: [String: String]? {
        switch self {
        case .fetchAlbum(let text):
            return ["term": text,
                    "media": "all",
                    "entity": "album",
                    "limit": "1000"]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .fetchAlbum:
            return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

private extension String {
    
    var utf8Encoded: Data { return data(using: .utf8)! }
}
