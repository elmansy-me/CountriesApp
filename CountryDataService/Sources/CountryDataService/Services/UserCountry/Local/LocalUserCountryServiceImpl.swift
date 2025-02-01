//
//  File.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import DatabaseKit

class LocalUserCountryServiceImpl: LocalUserCountryService {
    
    private let databaseService: DatabaseService
    private let cachedUserCountryKey = "cachedUserCountry"
    private let cachedStarredCountryKey = "cachedStarredCountries"

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func fetchCachedCountry() -> Country? {
        try? databaseService.get(forKey: cachedUserCountryKey, as: Country.self)
    }
    
    func fetchCachedStarredCountries() -> [Country]? {
        try? databaseService.get(forKey: cachedStarredCountryKey, as: [Country].self)
    }
    
    func saveCountry(_ country: Country) {
        try? databaseService.save(country, forKey: cachedUserCountryKey)
    }
    
    func saveStarredCountries(_ countries: [Country]) {
        try? databaseService.save(countries, forKey: cachedStarredCountryKey)
    }
}
