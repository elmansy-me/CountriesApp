//
//  UserCountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import NetworkLayer
import DatabaseKit

public final class UserCountryRepositoryBuilder {
    static public func build() -> UserCountryRepository {
        let networkService = NetworkService()
        
        let remoteCountriesService = RemoteCountryService(networkService: networkService)
        let database = UserDefaultsDatabase()
        
        let countriesRepository = CountryRepositoryImpl(
            remoteService: remoteCountriesService,
            database: database,
            networkMonitor: NetworkMonitorServiceImpl()
        )
        
        let remoteService = RemoteCountryCodeService(networkService: networkService)
        let userLocationService = UserLocationServiceImpl()
        
        let repository = UserCountryRepositoryImpl(
            repository: countriesRepository,
            remoteService: remoteService,
            userLocationService: userLocationService,
            database: database,
            networkMonitor: NetworkMonitorServiceImpl()
        )
        return repository
    }
}
