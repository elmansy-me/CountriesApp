//
//  LocalCountryServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import DatabaseKit

class LocalCountryServiceImpl: LocalCountryService {
    
    private let database: DatabaseService
    private let countriesKey = "cachedCountries"

    init(database: DatabaseService) {
        self.database = database
    }
    
    func fetchCachedCountries() -> [Country]? {
        try? database.get(forKey: countriesKey, as: [Country].self)
    }
    
    func fetchCachedCountry(countryCode: String) -> Country? {
        fetchCachedCountries()?.first { $0.countryCode == countryCode }
    }
    
    func saveCountries(_ countries: [Country]) throws {
        try database.save(countries, forKey: countriesKey)
    }
    
    func saveCountry(_ country: Country) throws {
        var cachedCountries = fetchCachedCountries() ?? []
        if !cachedCountries.contains(where: { $0.countryCode == country.countryCode }) {
            cachedCountries.append(country)
            try database.save(cachedCountries, forKey: countriesKey)
        }
    }
}
