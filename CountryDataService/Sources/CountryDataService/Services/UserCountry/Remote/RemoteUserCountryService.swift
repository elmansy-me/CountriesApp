//
//  File.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol RemoteUserCountryService {
    func fetchCountryCode() async throws -> String
    func fetchRemoteCountry(countryCode: String) async throws -> Country
    func fetchRemoteStarredCountries() async throws -> [Country]
}
