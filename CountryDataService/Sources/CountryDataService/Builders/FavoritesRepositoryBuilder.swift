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
        let databaseService = UserDefaultsDatabase()
        let localService = LocalFavoritesServiceImpl(database: databaseService)
        
        return FavoritesRepositoryImpl(localService: localService)
    }
}
