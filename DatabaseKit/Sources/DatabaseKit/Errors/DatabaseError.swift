//
//  DatabaseError.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public enum DatabaseError: Error, Equatable {
    case encodingFailed(Error)
    case decodingFailed(Error)
    case dataNotFound

    public static func == (lhs: DatabaseError, rhs: DatabaseError) -> Bool {
        switch (lhs, rhs) {
        case (.dataNotFound, .dataNotFound):
            return true
        case let (.encodingFailed(lhsError), .encodingFailed(rhsError)),
             let (.decodingFailed(lhsError), .decodingFailed(rhsError)):
            let lhsNSError = lhsError as NSError
            let rhsNSError = rhsError as NSError
            return lhsNSError.domain == rhsNSError.domain && lhsNSError.code == rhsNSError.code
        default:
            return false
        }
    }
}

