//
//  SearchInteractorImpl.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import CountryDataService

class SearchInteractorImpl: SearchInteractor {
    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func fetchCountries() async throws -> [CountryListItem] {
        let countries = try await repository.fetchCountries()
        return countries.map { country in
            CountryListItem(
                name: country.name,
                flagURL: country.flags?["png"],
                countryCode: country.countryCode
            )
        }
    }

    func search(query: String, allCountries: [CountryListItem]) -> [CountryListItem]? {
        guard !query.isEmpty else { return [] }
        let lowercasedQuery = query.lowercased()
        let result = allCountries.filter { $0.name.lowercased().contains(lowercasedQuery) }
        return result.isEmpty ? nil : result
    }
}
