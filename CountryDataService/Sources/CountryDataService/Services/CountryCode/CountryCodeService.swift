//
//  CountryCodeService.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol CountryCodeService {
    func getCountryCode() async throws -> String
}
