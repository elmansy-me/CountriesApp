//
//  RemoteCountryCodeServiceImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import NetworkLayer

class RemoteCountryCodeServiceImpl: RemoteCountryCodeService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCountryCode() async throws -> String {
        let request = CountryRequests.getCurrentCountryCode
        let response = try await networkService.request(request)
        
        if let countryCode = String(data: response, encoding: .utf8) {
            return countryCode
        } else {
            throw CountryError.custom("Failed to parse country code response")
        }
    }
}
