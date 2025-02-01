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
        let localService = LocalUserCountryServiceImpl(databaseService: databaseService)
        let remoteService = RemoteUserCountryServiceBuilder.build()
        let networkMonitor = NetworkMonitorServiceImpl()
        
        return UserCountryRepositoryImpl(
            localService: localService,
            remoteService: remoteService,
            networkMonitor: networkMonitor
        )
    }
}
