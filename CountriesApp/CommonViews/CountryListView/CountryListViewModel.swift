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
        let countryRepository = CountryRepositoryBuilder.build()
        let favoritesRepository = FavoritesRepositoryBuilder.build()

        let interactor = CountryDetailsInteractorImpl(
            countryRepository: countryRepository,
            favoritesRepository: favoritesRepository
        )

        let viewModel = CountryDetailsViewModel(
            countryCode: countryCode,
            interactor: interactor
        )
        let view = CountryDetailsView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
}
