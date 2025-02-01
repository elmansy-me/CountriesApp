//
//  RemoteCountryService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol RemoteCountryService {
    func fetchCountries() async throws -> [Country]
    func fetchCountry(countryCode: String) async throws -> Country
}
