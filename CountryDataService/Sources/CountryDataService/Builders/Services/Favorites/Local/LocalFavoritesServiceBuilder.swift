//
//  LocalFavoritesServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

final class LocalFavoritesServiceBuilder {
    static func build() -> LocalFavoritesService {
        let databaseService = UserDefaultsDatabaseBuilder.build()
        let service = LocalFavoritesServiceImpl(database: databaseService)
        return service
    }
}
