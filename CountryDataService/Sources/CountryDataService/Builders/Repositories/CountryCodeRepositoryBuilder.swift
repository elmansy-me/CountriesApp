//
//  CountryCodeRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

public final class CountryCodeRepositoryBuilder {
    static public func build() -> CountryCodeRepository {
        let localService = LocalCountryCodeServiceBuilder.build()
        let remoteService = RemoteCountryCodeServiceBuilder.build()

        return CountryCodeRepositoryImpl(
            localService: localService,
            remoteService: remoteService
        )
    }
}
