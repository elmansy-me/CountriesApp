//
//  RemoteUserCountryServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class RemoteUserCountryServiceImpl: RemoteUserCountryService {
    
    private let countryRepository: CountryRepository
    private let countryCodeRepository: CountryCodeRepository

    init(countryRepository: CountryRepository, countryCodeRepository: CountryCodeRepository) {
        self.countryRepository = countryRepository
        self.countryCodeRepository = countryCodeRepository
    }

    func fetchCountryCode() async throws -> String {
        return try await countryCodeRepository.getCountryCode()
    }

    func fetchCountry(countryCode: String) async throws -> Country {
        return try await countryRepository.fetchCountry(countryCode: countryCode)
    }
}
