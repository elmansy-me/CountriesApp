//
//  CountryListViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import CountryDataService

@MainActor
class CountryListViewModel: BaseViewModel {
    
    let countries: [CountryListItem]
    
    init(countries: [Country]) {
        self.countries = Self.mapCountriesToListItems(countries)
    }
    
    private static func mapCountriesToListItems(_ countries: [Country]) -> [CountryListItem] {
        countries.map({ country in
            CountryListItem(
                name: country.name,
                flagURL: country.flags?["png"],
                countryCode: country.countryCode
            )
        })
    }
    
    func navigateToDetail(countryCode: String) {
        let repository = CountryRepositoryBuilder.build()
        let viewModel = CountryDetailsViewModel(countryCode: countryCode, repository: repository)
        let view = CountryDetailsView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
}
