//
//  UserCountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

class UserCountryRepositoryImpl: UserCountryRepository {
    
    private let localService: LocalUserCountryService
    private let remoteService: RemoteUserCountryService
    private let networkMonitor: NetworkMonitorService

    init(
        localService: LocalUserCountryService,
        remoteService: RemoteUserCountryService,
        networkMonitor: NetworkMonitorService
    ) {
        self.localService = localService
        self.remoteService = remoteService
        self.networkMonitor = networkMonitor
    }
    
    func getCountry() async throws -> Country {
        let isConnected = await networkMonitor.isConnected()

        if !isConnected, let cachedCountry = localService.fetchCachedCountry() {
            return cachedCountry
        }
        
        let countryCode = try await remoteService.fetchCountryCode()
        let country = try await remoteService.fetchCountry(countryCode: countryCode)
        localService.saveCountry(country)
        return country
    }
    
    func getStarredCountries() async throws -> [Country] {
        localService.fetchCachedStarredCountries() ?? []
    }
}
