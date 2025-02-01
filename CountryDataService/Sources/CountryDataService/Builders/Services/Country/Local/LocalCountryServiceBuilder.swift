//
//  LocalCountryServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

final class LocalCountryServiceBuilder {
    static public func build() -> LocalCountryService {
        let databaseService = UserDefaultsDatabaseBuilder.build()
        let service = LocalCountryServiceImpl(database: databaseService)
        return service
    }
}
