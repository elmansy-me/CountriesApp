//
//  CountryListViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import CountryDataService

class CountryListViewModel: ObservableObject {
    
    let countries: [CountryListItem]
    
    init(countries: [Country]) {
        self.countries = Self.mapCountriesToListItems(countries)
    }
    
    private static func mapCountriesToListItems(_ countries: [Country]) -> [CountryListItem] {
        countries.map({ country in
            CountryListItem(
                name: country.name,
                flagURL: country.flags?["png"]
            )
        })
    }
    
}
