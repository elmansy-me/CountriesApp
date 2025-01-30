//
//  AllCountriesView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct AllCountriesView: View {
    
    @StateObject private var viewModel: AllCountriesViewModel
    
    init(viewModel: AllCountriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.allCountries {
            case .loading:
                LoadingView()
            case .success(let list):
                List {
                    Section {
                        CountryListView(countries: list)
                    }
                }
                .listStyle(.insetGrouped)
            case .failure(let error):
                MessageView(message: error, retryAction: {
                    viewModel.retry()
                })
            }
        }
        .navigationTitle("Countries")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.searchButtonTapped ) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .task {
            await viewModel.loadCountries()
        }
    }
}
