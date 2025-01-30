//
//  CountryListView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

struct CountryListView: View {
    
    @StateObject var viewModel: CountryListViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    init(countries: [Country]) {
        _viewModel = StateObject(wrappedValue: CountryListViewModel(countries: countries))
    }
    
    
    var body: some View {
        ForEach(viewModel.countries, id: \.name) { country in
            Button(action: {
                viewModel.navigateToDetail(countryCode: country.countryCode)
            }) {
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
                .background(Color(.systemBackground))
            }
            .buttonStyle(PlainButtonStyle())
            .contentShape(Rectangle())
        }
        .listStyle(PlainListStyle())
        .onAppear {
            viewModel.provideCoordinator(coordinator)
        }
    }
}
