//
//  UserCountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import NetworkLayer

public final class UserCountryRepositoryBuilder {
    static public func build() -> UserCountryRepository {
        let networkService = NetworkService()
        
        let remoteCountriesService = RemoteCountryService(networkService: networkService)
        let countriesRepository = CountryRepositoryImpl(remoteService: remoteCountriesService)
        
        let remoteService = RemoteCountryCodeService(networkService: networkService)
        let userLocationService = UserLocationServiceImpl()
        let repository = UserCountryRepositoryImpl(
            repository: countriesRepository,
            remoteService: remoteService,
            userLocationService: userLocationService
        )
        return repository
    }
}
