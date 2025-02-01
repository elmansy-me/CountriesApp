//
//  CountryRepository.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public protocol CountryRepository {
    func fetchCountries() async throws -> [Country]
    func fetchCountry(countryCode: String) async throws -> Country
}
