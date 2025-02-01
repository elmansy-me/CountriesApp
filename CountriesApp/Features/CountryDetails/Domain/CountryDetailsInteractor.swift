//
//  CountryDetailsInteractor.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation

protocol CountryDetailsInteractor {
    func fetchCountryDetails(countryCode: String) async throws -> CountryDetailsViewItem
    func toggleStar() throws
    func isStarred(countryCode: String) -> Bool
}
