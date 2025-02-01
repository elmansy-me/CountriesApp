//
//  LocalUserCountryServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

final class LocalUserCountryServiceBuilder {
    static func build() -> LocalUserCountryService {
        let databaseService = UserDefaultsDatabaseBuilder.build()
        let service = LocalUserCountryServiceImpl(databaseService: databaseService)
        return service
    }
}
