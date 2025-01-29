//
//  CountryRepositoryBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import NetworkLayer

public final class CountryRepositoryBuilder {
    static public func build() -> CountryRepository {
        let networkService = NetworkService()
        let remoteService = RemoteCountryService(networkService: networkService)
        let repository = CountryRepositoryImpl(remoteService: remoteService)
        return repository
    }
}
