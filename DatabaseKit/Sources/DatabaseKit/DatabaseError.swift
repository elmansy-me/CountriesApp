//
//  DatabaseError.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public enum DatabaseError: Error {
    case encodingFailed(Error)
    case decodingFailed(Error)
    case dataNotFound
}
