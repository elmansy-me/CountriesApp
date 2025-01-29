//
//  Country.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public struct Country: Codable {
    let name: String
    let capital: String?
    let currencies: [Currency]?
    let flag: String?
}
