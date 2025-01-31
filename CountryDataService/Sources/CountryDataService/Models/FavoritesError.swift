//
//  FavoritesError.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

enum FavoritesError: Error, LocalizedError {
    case limitExceeded(maxLimit: Int)
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .limitExceeded(let maxLimit):
            return "You can only add \(maxLimit) countries to your favorites list."
        case .custom(let message):
            return message
        }
    }
}
