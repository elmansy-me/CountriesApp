//
//  CountryCodeRepositoryImpl.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class CountryCodeRepositoryImpl: CountryCodeRepository {
    
    private let localService: LocalCountryCodeService
    private let remoteService: RemoteCountryCodeService
    
    init(localService: LocalCountryCodeService, remoteService: RemoteCountryCodeService) {
        self.localService = localService
        self.remoteService = remoteService
    }
    
    func getCountryCode() async throws -> String {
        do {
            return try await localService.getCountryCode()
        } catch {
            return try await remoteService.getCountryCode()
        }
    }
}
