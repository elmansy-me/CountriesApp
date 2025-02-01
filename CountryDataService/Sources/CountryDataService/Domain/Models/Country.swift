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
    
    public init(name: String = "", capital: String? = nil, currencies: [Currency]? = nil, flags: [String : String]? = nil, alpha2Code: String = "") {
        self.name = name
        self.capital = capital
        self.currencies = currencies
        self.flags = flags
        self.alpha2Code = alpha2Code
    }
}
