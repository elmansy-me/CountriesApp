//
//  FavoritesRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import DatabaseKit

public final class FavoritesRepositoryBuilder {
    static public func build() -> FavoritesRepository {
        let database = UserDefaultsDatabase()
        let repository = FavoritesRepositoryImpl(database: database)
        return repository
    }
}
