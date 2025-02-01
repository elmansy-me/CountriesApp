//
//  FavoritesRepository.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

public protocol FavoritesRepository {
    func toggleStar(for country: Country) throws
    func isStarred(countryCode: String) throws -> Bool
    func getStarredCountries() throws -> [Country]
}
