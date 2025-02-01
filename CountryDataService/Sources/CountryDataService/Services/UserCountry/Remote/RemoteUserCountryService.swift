//
//  RemoteUserCountryService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol RemoteUserCountryService {
    func fetchCountryCode() async throws -> String
    func fetchCountry(countryCode: String) async throws -> Country
}
