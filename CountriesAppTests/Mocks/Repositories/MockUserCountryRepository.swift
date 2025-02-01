//
//  MockUserCountryRepository.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountryDataService

class MockUserCountryRepository: UserCountryRepository {
    var mockCountry: Country?
    var mockStarredCountries: [Country] = []
    var mockError: Error?

    func getCountry() async throws -> Country {
        if let mockError {
            throw mockError
        } else if let mockCountry {
            return mockCountry
        }
        fatalError("Must have mocked country or error")
    }
    
    func getStarredCountries() async throws -> [Country] {
        if let mockError {
            throw mockError
        } else {
            return mockStarredCountries
        }
    }
}
