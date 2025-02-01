//
//  CountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import DatabaseKit

class CountryRepositoryImpl: CountryRepository {
    
    private let remoteService: RemoteCountryService
    private let database: DatabaseService
    private let networkMonitor: NetworkMonitorService
    private let countriesKey = "cachedCountries"
    
    init(
        remoteService: RemoteCountryService,
        database: DatabaseService,
        networkMonitor: NetworkMonitorService
    ) {
        self.remoteService = remoteService
        self.database = database
        self.networkMonitor = networkMonitor
    }
    
    func fetchCountries() async throws -> [Country] {
        let isConnected = await networkMonitor.isConnected()
        
        if !isConnected, let cachedCountries = fetchCachedCountries() {
            return cachedCountries
        }
        
        return try await fetchRemoteCountries()
    }
    
    func fetchCountry(countryCode: String) async throws -> Country {
        let isConnected = await networkMonitor.isConnected()
        
        if !isConnected, let cachedCountry = fetchCachedCountry(countryCode: countryCode) {
            return cachedCountry
        }
        
        let country = try await fetchRemoteCountry(countryCode: countryCode)
        try? saveCountry(country)
        return country
    }
    
}

private extension CountryRepositoryImpl {
    
    func fetchRemoteCountries() async throws -> [Country] {
        let data = try await remoteService.fetchCountries()
        try? database.save(data, forKey: countriesKey)
        return data
    }
    
    func fetchCachedCountries() -> [Country]? {
        try? database.get(forKey: countriesKey, as: [Country].self)
    }
    
}


private extension CountryRepositoryImpl {
    
    func fetchCachedCountry(countryCode: String) -> Country? {
        fetchCachedCountries()?.first { $0.countryCode == countryCode }
    }
    
    func fetchRemoteCountry(countryCode: String) async throws -> Country {
        try await remoteService.fetchCountry(countryCode: countryCode)
    }
    
    func saveCountry(_ country: Country) throws {
        var cachedCountries = fetchCachedCountries() ?? []
        if !cachedCountries.contains(where: { $0.countryCode == country.countryCode }) {
            cachedCountries.append(country)
            try database.save(cachedCountries, forKey: countriesKey)
        }
    }
    
}
