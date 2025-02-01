//
//  MockFavoritesRepository.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountryDataService

class MockFavoritesRepository: FavoritesRepository {
    var starredCountries: [Country] = []
    var mockedError: Error?

    func toggleStar(for country: Country) throws {
        if let mockedError {
            throw mockedError
        }
        if let index = starredCountries.firstIndex(where: { $0.countryCode == country.countryCode }) {
            starredCountries.remove(at: index)
        } else {
            starredCountries.append(country)
        }
    }

    func isStarred(countryCode: String) throws -> Bool {
        starredCountries.contains(where: { $0.countryCode == countryCode })
    }

    func getStarredCountries() throws -> [Country] {
        starredCountries
    }
}
