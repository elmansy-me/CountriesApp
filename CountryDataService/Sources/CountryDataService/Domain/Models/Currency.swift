//
//  Currency.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation

public struct Currency: Codable, Sendable {
    public let code, name, symbol: String
    
    public init(code: String, name: String, symbol: String) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
}
