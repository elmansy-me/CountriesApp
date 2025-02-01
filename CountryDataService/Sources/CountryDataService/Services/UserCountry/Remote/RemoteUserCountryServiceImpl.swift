//
//  RemoteUserCountryServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class RemoteUserCountryServiceImpl: RemoteUserCountryService {
    
    private let repository: CountryRepository
    private let remoteService: CountryCodeService
    private let localService: CountryCodeService

    init(repository: CountryRepository, remoteService: CountryCodeService, localService: CountryCodeService) {
        self.repository = repository
        self.remoteService = remoteService
        self.localService = localService
    }

    func fetchCountryCode() async throws -> String {
        if let countryCode = try? await localService.getCountryCode() {
            return countryCode
        }
        return try await remoteService.getCountryCode()
    }

    func fetchRemoteCountry(countryCode: String) async throws -> Country {
        return try await repository.fetchCountry(countryCode: countryCode)
    }

    func fetchRemoteStarredCountries() async throws -> [Country] {
        let data = try await repository.fetchCountries()
        return Array(data.prefix(5))
    }
}
