//
//  UserCountryRepository.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

public protocol UserCountryRepository {
    func getCountry() async throws -> Country
    func getStarredCountries() async throws -> [Country]
}
