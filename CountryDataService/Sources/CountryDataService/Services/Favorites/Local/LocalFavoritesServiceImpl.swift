//
//  LocalFavoritesServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import DatabaseKit

class LocalFavoritesServiceImpl: LocalFavoritesService {
    
    private let database: DatabaseService
    private let key = "starredCountries"

    init(database: DatabaseService) {
        self.database = database
    }
    
    func fetchStarredCountries() throws -> [Country] {
        do {
            return try database.get(forKey: key, as: [Country].self)
        } catch DatabaseError.dataNotFound {
            return []
        }
    }
    
    func saveStarredCountries(_ countries: [Country]) throws {
        try database.save(countries, forKey: key)
    }
}
