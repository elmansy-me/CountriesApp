//
//  Country.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public struct Country: Codable, Sendable {
    public let name: String
    public let capital: String?
    public let currencies: [Currency]?
    public let flags: [String: String]?
    let alpha2Code: String
    
    public var countryCode: String {
        alpha2Code
    }
}
