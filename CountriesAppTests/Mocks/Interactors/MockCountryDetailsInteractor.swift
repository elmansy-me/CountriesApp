//
//  MockCountryDetailsInteractor.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
@testable import CountriesApp

class MockCountryDetailsInteractor: CountryDetailsInteractor {
    var mockCountryDetails: CountryDetailsViewItem?
    var mockError: Error?
    var isCurrentlyStarred = false

    func fetchCountryDetails(countryCode: String) async throws -> CountryDetailsViewItem {
        if let mockError {
            throw mockError
        } else if let mockCountryDetails {
            return mockCountryDetails
        }
        fatalError("Must provide country or error")
    }

    func toggleStar() throws {
        if let mockError {
            throw mockError
        }
        isCurrentlyStarred.toggle()
    }

    func isStarred(countryCode: String) -> Bool {
        isCurrentlyStarred
    }
}
