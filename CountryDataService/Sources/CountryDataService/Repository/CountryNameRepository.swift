//
//  CountryNameRepository.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation

public protocol CountryNameRepository {
    func getCountryName() async throws -> String
}
