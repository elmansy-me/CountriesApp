//
//  SearchInteractor.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

protocol SearchInteractor {
    func fetchCountries() async throws -> [CountryListItem]
    func search(query: String, allCountries: [CountryListItem]) -> [CountryListItem]?
}
