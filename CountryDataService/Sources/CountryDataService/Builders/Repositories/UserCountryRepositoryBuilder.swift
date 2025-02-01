//
//  UserCountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

public final class UserCountryRepositoryBuilder {
    static public func build() -> UserCountryRepository {
        let localService = LocalUserCountryServiceBuilder.build()
        let remoteService = RemoteUserCountryServiceBuilder.build()
        let networkMonitor = NetworkMonitorServiceBuilder.build()
        
        return UserCountryRepositoryImpl(
            localService: localService,
            remoteService: remoteService,
            networkMonitor: networkMonitor
        )
    }
}
