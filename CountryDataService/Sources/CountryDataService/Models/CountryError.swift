//
//  CountryError.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

enum CountryError: Error, LocalizedError {
    case countryNotFound
    case unknown(Error)
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .countryNotFound:
            return "Country not found"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        case .custom(let message):
            return message
        }
    }
}
