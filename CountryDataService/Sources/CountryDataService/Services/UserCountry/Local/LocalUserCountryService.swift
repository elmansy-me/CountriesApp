//
//  LocalUserCountryService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol LocalUserCountryService {
    func fetchCachedCountry() -> Country?
    func fetchCachedStarredCountries() -> [Country]?
    func saveCountry(_ country: Country)
    func saveStarredCountries(_ countries: [Country])
}
