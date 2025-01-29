//
//  RemoteCountryService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import NetworkLayer

class RemoteCountryService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCountries() async throws -> [Country] {
        let request = CountryRequests.getAll
        let response = try await networkService.request(request, responseType: [Country].self)
        return response
    }
    
}
