//
//  CountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public final class CountryRepositoryBuilder {
    static public func build() -> CountryRepository {
        let remoteService = RemoteCountryServiceBuilder.build()
        let localService = LocalCountryServiceBuilder.build()
        let networkMonitor = NetworkMonitorServiceBuilder.build()

        return CountryRepositoryImpl(
            localService: localService,
            remoteService: remoteService,
            networkMonitor: networkMonitor
        )
    }
}
