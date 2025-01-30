//
//  CountryNameRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

class CountryNameRepositoryImpl: CountryNameRepository {
    
    private let remoteService: RemoteCountryNameService
    private let userLocationService: UserLocationService

    init(remoteService: RemoteCountryNameService, userLocationService: UserLocationService) {
        self.remoteService = remoteService
        self.userLocationService = userLocationService
    }
    
    func getCountryName() async throws -> String {
        if let result = await userLocationService.getUserCountry() {
            return result
        }
        
        let result = try await remoteService.getCountryNameFromIP()
        return result
    }
    
}
