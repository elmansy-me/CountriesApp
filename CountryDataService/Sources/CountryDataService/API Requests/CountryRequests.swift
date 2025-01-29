//
//  CountryRequests.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import NetworkLayer

enum CountryRequests: APIRequest {
    
    case getAll
    
    var scheme: URLScheme {
        .https
    }
    
    var host: String {
        "restcountries.com"
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/v2/all"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var body: Data? {
        nil
    }
    
    var queryParameters: [String : String]? {
        nil
    }
    
}
