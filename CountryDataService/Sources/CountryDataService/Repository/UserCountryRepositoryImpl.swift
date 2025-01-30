//
//  UserCountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

class UserCountryRepositoryImpl: UserCountryRepository {
    
    private let repository: CountryRepository
    private let remoteService: RemoteCountryCodeService
    private let userLocationService: UserLocationService

    init(
        repository: CountryRepository,
        remoteService: RemoteCountryCodeService,
        userLocationService: UserLocationService
    ) {
        self.repository = repository
        self.remoteService = remoteService
        self.userLocationService = userLocationService
    }
    
    func getCountry() async throws -> Country {
        if let countryCode = await userLocationService.getCountryCode() {
            return try await getCountry(countryCode: countryCode)
        }
        
        let countryCode = try await remoteService.getCountryCode()
        return try await getCountry(countryCode: countryCode)
    }
    
    private func getCountry(countryCode: String) async throws -> Country {
        try await repository.fetchCountry(countryCode: countryCode)
    }
    
    func getStarredCountries() async throws -> [Country] {
        let data = try await repository.fetchCountries()
        let result = Array(data.prefix(5))
        return result
    }
    
}
