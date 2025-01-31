//
//  UserDefaultsDatabaseService.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public class UserDefaultsDatabase: DatabaseService {
    private let defaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }

    public func save<T: Codable>(_ object: T, forKey key: String) throws {
        do {
            let data = try JSONEncoder().encode(object)
            defaults.set(data, forKey: key)
        } catch {
            throw DatabaseError.encodingFailed(error)
        }
    }

    public func get<T: Codable>(forKey key: String, as type: T.Type) throws -> T {
        guard let data = defaults.data(forKey: key) else {
            throw DatabaseError.dataNotFound
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DatabaseError.decodingFailed(error)
        }
    }

    public func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }

    public func clearAll() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
    }
}

