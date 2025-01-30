//
//  SearchView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if let countries = viewModel.countries {
                CountryListView(countries: countries)
            } else {
                ErrorView(message: "Oops! We couldn't find any results matching your search")
            }
        }
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
    }
}
