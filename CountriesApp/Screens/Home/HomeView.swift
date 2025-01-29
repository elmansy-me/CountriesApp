//
//  HomeView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.allCountries {
                case .loading:
                    LoadingView()
                case .success(let list):
                    CountryListView(countries: list)
                case .failure(let error):
                    ErrorView(errorMessage: error, retryAction: {
                        viewModel.retry()
                    })
                }
            }
            .navigationTitle("Countries")
            .task {
                await viewModel.loadCountries()
            }
        }
    }
}
