//
//  CountryListView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

struct CountryListView: View {
    let countries: [Country]

    var body: some View {
        List(countries, id: \.name) { country in
            Text(country.name)
        }
        .listStyle(PlainListStyle())
    }
}
