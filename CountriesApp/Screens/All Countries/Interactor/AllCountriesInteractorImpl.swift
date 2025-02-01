//
//  AllCountriesInteractorImpl.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation
import CountryDataService

class AllCountriesInteractorImpl: AllCountriesInteractor {
    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
    }

    func fetchCountries() async throws -> [CountryListItem] {
        let result = try await repository.fetchCountries()
        let countries = mapCountriesToListItems(result)
        return countries
    }
    
    private func mapCountriesToListItems(_ countries: [Country]) -> [CountryListItem] {
        countries.map({ country in
            CountryListItem(
                name: country.name,
                flagURL: country.flags?["png"],
                countryCode: country.countryCode
            )
        })
    }
}

