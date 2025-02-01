//
//  File.swift
//  CountryDataService
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol LocalFavoritesService {
    func fetchStarredCountries() throws -> [Country]
    func saveStarredCountries(_ countries: [Country]) throws
}
