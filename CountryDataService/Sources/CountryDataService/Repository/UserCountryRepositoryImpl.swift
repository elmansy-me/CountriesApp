//
//  UserCountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import DatabaseKit

class UserCountryRepositoryImpl: UserCountryRepository {
    
    private let repository: CountryRepository
    private let remoteService: RemoteCountryCodeService
    private let userLocationService: UserLocationService
    private let database: DatabaseService
    private let networkMonitor: NetworkMonitorService
    
    private let cachedUserCountryKey = "cachedUserCountry"
    private let cachedStarredCountryKey = "cachedStarredCountries"

    init(
        repository: CountryRepository,
        remoteService: RemoteCountryCodeService,
        userLocationService: UserLocationService,
        database: DatabaseService,
        networkMonitor: NetworkMonitorService
    ) {
        self.repository = repository
        self.remoteService = remoteService
        self.userLocationService = userLocationService
        self.database = database
        self.networkMonitor = networkMonitor
    }
    
    func getCountry() async throws -> Country {
        let isConnected = await networkMonitor.isConnected()

        if !isConnected, let country = fetchCachedCountry() {
            return country
        }
        
        let countryCode = try await fetchCountryCode()
        let country = try await fetchRemoteCountry(countryCode: countryCode)
        return country
    }
    
    func getStarredCountries() async throws -> [Country] {
        let isConnected = await networkMonitor.isConnected()

        if !isConnected, let countries = fetchCachedStarredCountries() {
            return countries
        }
        
        let countries = try await fetchRemoteStarredCountries()
        return countries
    }
    
}


private extension UserCountryRepositoryImpl {
    
    func fetchCachedCountry() -> Country? {
        try? database.get(forKey: cachedUserCountryKey, as: Country.self)
    }
    
    func fetchCountryCode() async throws -> String {
        if let countryCode = await userLocationService.getCountryCode() {
            return countryCode
        }
        
        let countryCode = try await remoteService.getCountryCode()
        return countryCode
    }
    
    func fetchRemoteCountry(countryCode: String) async throws -> Country {
        let country = try await repository.fetchCountry(countryCode: countryCode)
        try? database.save(country, forKey: cachedUserCountryKey)
        return country
    }
}


private extension UserCountryRepositoryImpl {
    
    func fetchCachedStarredCountries() -> [Country]? {
        try? database.get(forKey: cachedStarredCountryKey, as: [Country].self)
    }
    
    func fetchRemoteStarredCountries() async throws -> [Country] {
        let data = try await repository.fetchCountries()
        let result = Array(data.prefix(5))
        try? database.save(result, forKey: cachedStarredCountryKey)
        return result
    }
}
