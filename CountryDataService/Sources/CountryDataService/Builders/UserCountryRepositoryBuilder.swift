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
        let databaseService = UserDefaultsDatabase()
        let networkMonitor = NetworkMonitorServiceImpl()
        
        let countryRepository = CountryRepositoryBuilder.build()
        let remoteService = RemoteUserCountryServiceImpl(
            repository: countryRepository,
            remoteService: RemoteCountryCodeService(networkService: NetworkService()),
            localService: LocalCountryCodeService()
        )
        let localService = LocalUserCountryServiceImpl(databaseService: databaseService)
        
        return UserCountryRepositoryImpl(
            localService: localService,
            remoteService: remoteService,
            networkMonitor: networkMonitor
        )
    }
}
