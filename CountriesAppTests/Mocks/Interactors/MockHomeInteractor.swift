//
//  MockHomeInteractor.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountriesApp
@testable import CountryDataService

class MockHomeInteractor: HomeInteractor {
    var mockSections: [HomeViewSectionItem] = []
    var mockError: Error?
    var starredCountries: Set<String> = []

    func getSections() async throws -> [HomeViewSectionItem] {
        if let mockError {
            throw mockError
        }
        return mockSections
    }

    func toggleStar(countryCode: String) async throws -> [HomeViewSectionItem] {
        if let mockError {
            throw mockError
        }
        if starredCountries.contains(countryCode) {
            starredCountries.remove(countryCode)
        } else {
            starredCountries.insert(countryCode)
        }
        return mockSections
    }

    func isStarred(countryCode: String) -> Bool {
        starredCountries.contains(countryCode)
    }
}
