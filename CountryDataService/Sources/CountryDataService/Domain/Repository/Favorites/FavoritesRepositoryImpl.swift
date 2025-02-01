//
//  FavoritesRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public class FavoritesRepositoryImpl: FavoritesRepository {
    
    private let localService: LocalFavoritesService
    private let maxStarredCount = 5

    init(localService: LocalFavoritesService) {
        self.localService = localService
    }

    public func toggleStar(for country: Country) throws {
        var starredCountries = try localService.fetchStarredCountries()

        if let index = starredCountries.firstIndex(where: { $0.countryCode == country.countryCode }) {
            starredCountries.remove(at: index)
        } else {
            if starredCountries.count >= maxStarredCount {
                throw FavoritesError.limitExceeded(maxLimit: maxStarredCount)
            }
            starredCountries.append(country)
        }

        try localService.saveStarredCountries(starredCountries)
    }

    public func isStarred(countryCode: String) throws -> Bool {
        try localService.fetchStarredCountries().contains { $0.countryCode == countryCode }
    }

    public func getStarredCountries() throws -> [Country] {
        try localService.fetchStarredCountries()
    }
}


