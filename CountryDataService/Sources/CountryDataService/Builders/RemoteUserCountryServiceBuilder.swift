//
//  RemoteUserCountryServiceBuilder.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class RemoteUserCountryServiceBuilder {
    static func build() -> RemoteUserCountryService {
        let countryRepository = CountryRepositoryBuilder.build()
        let countryCodeRepository = CountryCodeRepositoryBuilder.build()

        return RemoteUserCountryServiceImpl(
            countryRepository: countryRepository,
            countryCodeRepository: countryCodeRepository
        )
    }
}
