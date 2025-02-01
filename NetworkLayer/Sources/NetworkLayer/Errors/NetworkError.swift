//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case noResponse
    case statusCode(Int)
    case decodingError(Error)
    case apiError(APIErrorResponse)
    case unknown(Error)

    public var errorDescription: String? {
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
            return error.localizedDescription
        }
    }
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.noResponse, .noResponse):
            return true
        case let (.statusCode(lhsCode), .statusCode(rhsCode)):
            return lhsCode == rhsCode
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.apiError(lhsError), .apiError(rhsError)):
            return lhsError.message == rhsError.message &&
                   lhsError.status == rhsError.status
        case let (.unknown(lhsError), .unknown(rhsError)):
            return (lhsError as NSError).domain == (rhsError as NSError).domain &&
            (lhsError as NSError).localizedDescription == (rhsError as NSError).localizedDescription
        default:
            return false
        }
    }
}
