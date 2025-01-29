//
//  CountryRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

class CountryRepositoryImpl: CountryRepository {
    
    private let remoteService: RemoteCountryService

    init(remoteService: RemoteCountryService) {
        self.remoteService = remoteService
    }

    func fetchCountries() async throws -> [Country] {
        let data = try await remoteService.fetchCountries()
        return data
    }
}
