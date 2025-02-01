//
//  File.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol LocalCountryService {
    func fetchCachedCountries() -> [Country]?
    func fetchCachedCountry(countryCode: String) -> Country?
    func saveCountries(_ countries: [Country]) throws
    func saveCountry(_ country: Country) throws
}
