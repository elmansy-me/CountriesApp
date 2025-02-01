//
//  CountryCodeRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import NetworkLayer

public final class CountryCodeRepositoryBuilder {
    static public func build() -> CountryCodeRepository {
        let networkService = NetworkService()
        let localService = LocalCountryCodeServiceImpl()
        let remoteService = RemoteCountryCodeServiceImpl(networkService: networkService)

        return CountryCodeRepositoryImpl(
            localService: localService,
            remoteService: remoteService
        )
    }
}
