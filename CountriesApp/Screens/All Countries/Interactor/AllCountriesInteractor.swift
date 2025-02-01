//
//  AllCountriesInteractor.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol AllCountriesInteractor {
    func fetchCountries() async throws -> [CountryListItem]
}
