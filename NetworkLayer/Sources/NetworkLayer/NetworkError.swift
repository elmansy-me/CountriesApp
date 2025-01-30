//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noResponse
    case statusCode(Int)
    case decodingError(Error)
    case apiError(APIErrorResponse)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL is invalid."
        case .noResponse:
            return "No response received from the server."
        case .statusCode(let code):
            return "Request failed with status code: \(code)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .apiError(let error):
            return "\(error.message) (\(error.status))"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
