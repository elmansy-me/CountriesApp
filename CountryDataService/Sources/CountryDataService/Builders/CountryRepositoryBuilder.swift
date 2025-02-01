//
//  CountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import NetworkLayer
import DatabaseKit

public final class CountryRepositoryBuilder {
    static public func build() -> CountryRepository {
        let databaseService = UserDefaultsDatabase()
        let networkMonitor = NetworkMonitorServiceImpl()
        let networkService = NetworkService()
        
        let remoteService = RemoteCountryServiceImpl(networkService: networkService)
        let localService = LocalCountryServiceImpl(database: databaseService)

        return CountryRepositoryImpl(
            localService: localService,
            remoteService: remoteService,
            networkMonitor: networkMonitor
        )
    }
}
