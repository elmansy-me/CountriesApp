//
//  MockCountryRepository.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountriesApp
@testable import CountryDataService

class MockCountryRepository: CountryRepository {
    var mockCountries: [Country] = []
    var mockCountry: Country?
    var mockError: Error?

    func fetchCountries() async throws -> [Country] {
        if let mockError {
            throw mockError
        }
        return mockCountries
    }

    func fetchCountry(countryCode: String) async throws -> Country {
        if let mockError {
            throw mockError
        } else if let mockCountry {
            return mockCountry
        }
        fatalError("Must send mocked error or country")
    }
}
