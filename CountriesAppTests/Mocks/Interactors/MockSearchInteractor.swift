//
//  MockSearchInteractor.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountriesApp

class MockSearchInteractor: SearchInteractor {
    var mockCountries: [CountryListItem] = []
    var mockError: Error?

    func fetchCountries() async throws -> [CountryListItem] {
        if let mockError {
            throw mockError
        }
        return mockCountries
    }

    func search(query: String, allCountries: [CountryListItem]) -> [CountryListItem]? {
        guard !query.isEmpty else { return [] }
        let lowercasedQuery = query.lowercased()
        let result = allCountries.filter { $0.name.lowercased().contains(lowercasedQuery) }
        return result.isEmpty ? nil : result
    }
}
