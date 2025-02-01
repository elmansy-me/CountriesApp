//
//  CountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

class CountryRepositoryImpl: CountryRepository {
    
    private let localService: LocalCountryService
    private let remoteService: RemoteCountryService
    private let networkMonitor: NetworkMonitorService

    init(
        localService: LocalCountryService,
        remoteService: RemoteCountryService,
        networkMonitor: NetworkMonitorService
    ) {
        self.localService = localService
        self.remoteService = remoteService
        self.networkMonitor = networkMonitor
    }
    
    func fetchCountries() async throws -> [Country] {
        let isConnected = await networkMonitor.isConnected()
        
        if !isConnected, let cachedCountries = localService.fetchCachedCountries() {
            return cachedCountries
        }
        
        let countries = try await remoteService.fetchCountries()
        try? localService.saveCountries(countries)
        return countries
    }
    
    func fetchCountry(countryCode: String) async throws -> Country {
        let isConnected = await networkMonitor.isConnected()
        
        if !isConnected, let cachedCountry = localService.fetchCachedCountry(countryCode: countryCode) {
            return cachedCountry
        }
        
        let country = try await remoteService.fetchCountry(countryCode: countryCode)
        try? localService.saveCountry(country)
        return country
    }
}
