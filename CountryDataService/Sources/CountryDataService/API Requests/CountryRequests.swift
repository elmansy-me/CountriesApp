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
    case getCurrentCountryCode
    case getCountry(countryCode: String)
    
    var scheme: URLScheme {
        .https
    }
    
    var host: String {
        switch self {
        case .getAll, .getCountry:
            return "restcountries.com"
        case .getCurrentCountryCode:
            return "ipapi.co"
        }
    }
    
    var path: String {
        switch self {
        case .getAll:
            return "/v2/all"
        case .getCurrentCountryCode:
            return "/country_code"
        case .getCountry(let countryCode):
            return "/v2/alpha/\(countryCode)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .GET
        case .getCurrentCountryCode:
            return .GET
        case .getCountry:
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
