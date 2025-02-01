//
//  CountryCodeError.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

enum CountryCodeError: Error, LocalizedError {
    case notFound
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Country code not found"
        case .custom(let message):
            return message
        }
    }
}
