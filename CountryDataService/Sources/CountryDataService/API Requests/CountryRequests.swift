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
    case getCountryNameFromIP
    
    var scheme: URLScheme {
        .https
    }
    
    var host: String {
        switch self {
        case .getAll:
            return "restcountries.com"
        case .getCountryNameFromIP:
            return "ipapi.co"
        }
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/v2/all"
        case .getCountryNameFromIP:
            return "/country_name"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .GET
        case .getCountryNameFromIP:
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
