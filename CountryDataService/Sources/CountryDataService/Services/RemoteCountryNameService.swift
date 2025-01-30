//
//  RemoteCountryNameService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import NetworkLayer

class RemoteCountryNameService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCountryNameFromIP() async throws -> String {
        let request = CountryRequests.getCountryNameFromIP
        let response = try await networkService.request(request)
        return String(data: response, encoding: .utf8) ?? ""
    }
    
}
