//
//  CountryCodeRepository.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

public protocol CountryCodeRepository {
    func getCountryCode() async throws -> String
}
