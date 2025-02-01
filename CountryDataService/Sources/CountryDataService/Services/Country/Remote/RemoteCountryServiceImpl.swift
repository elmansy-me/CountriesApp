//
//  RemoteCountryServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import NetworkLayer

class RemoteCountryServiceImpl: RemoteCountryService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCountries() async throws -> [Country] {
        let request = CountryRequests.getAll
        let response = try await networkService.request(request, responseType: [Country].self)
        return response
    }
    
    func fetchCountry(countryCode: String) async throws -> Country {
        let request = CountryRequests.getCountry(countryCode: countryCode)
        let response = try await networkService.request(request, responseType: Country?.self)
        if let response {
            return response
        } else {
            throw CountryError.countryNotFound
        }
    }
    
}
