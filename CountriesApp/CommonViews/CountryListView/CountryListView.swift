//
//  CountryListView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    
    init(countries: [Country]) {
        self.viewModel = CountryListViewModel(countries: countries)
    }
    
    
    var body: some View {
        ForEach(viewModel.countries, id: \.name) { country in
            HStack {
                AsyncImageView(
                    url: country.flagURL,
                    placeholder: Image(systemName: "globe"),
                    size: .init(width: 32, height: 32)
                )
                
                Text(country.name)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.vertical, 6)
        }
        .listStyle(PlainListStyle())
    }
}
