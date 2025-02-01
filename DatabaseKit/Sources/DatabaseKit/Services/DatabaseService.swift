//
//  DatabaseService.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public protocol DatabaseService {
    func save<T: Codable>(_ object: T, forKey key: String) throws(DatabaseError)
    func get<T: Codable>(forKey key: String, as type: T.Type) throws(DatabaseError) -> T
    func remove(forKey key: String)
    func clearAll()
}
