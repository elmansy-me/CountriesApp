//
//  FavoritesRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import DatabaseKit

public class FavoritesRepositoryImpl: FavoritesRepository {
    private let database: DatabaseService
    private let key = "starredCountries"
    private let maxStarredCount = 5

    public init(database: DatabaseService) {
        self.database = database
    }

    public func toggleStar(for country: Country) throws {
        do {
            var starredCountries = try database.get(forKey: key, as: [Country].self)

            if let index = starredCountries.firstIndex(where: { $0.countryCode == country.countryCode }) {
                starredCountries.remove(at: index)
            } else {
                if starredCountries.count >= maxStarredCount {
                    throw FavoritesError.limitExceeded(maxLimit: maxStarredCount)
                }
                starredCountries.append(country)
            }

            try database.save(starredCountries, forKey: key)
        } catch DatabaseError.dataNotFound {
            try database.save([country], forKey: key)
        } catch {
            throw error
        }
    }

    public func isStarred(countryCode: String) throws -> Bool {
        do {
            return try database.get(forKey: key, as: [Country].self).contains { $0.countryCode == countryCode }
        } catch DatabaseError.dataNotFound {
            return false
        } catch {
            throw error
        }
    }

    public func getStarredCountries() throws -> [Country] {
        do {
            return try database.get(forKey: key, as: [Country].self)
        } catch DatabaseError.dataNotFound {
            return []
        } catch {
            throw error
        }
    }
}

