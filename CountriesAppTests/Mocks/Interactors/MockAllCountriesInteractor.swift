//
//  MockAllCountriesInteractor.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountriesApp

class MockAllCountriesInteractor: AllCountriesInteractor {
    var mockCountries: [CountryListItem] = []
    var mockError: Error?

    func fetchCountries() async throws -> [CountryListItem] {
        if let mockError {
            throw mockError
        }
        return mockCountries
    }
}
