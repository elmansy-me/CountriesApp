//
//  FavoritesRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public final class FavoritesRepositoryBuilder {
    static public func build() -> FavoritesRepository {
        let localService = LocalFavoritesServiceBuilder.build()
        return FavoritesRepositoryImpl(localService: localService)
    }
}
