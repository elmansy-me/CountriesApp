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
        VStack {
            switch viewModel.allCountries {
            case .loading:
                LoadingView()
            case .success(let list):
                CountryListView(countries: list)
            case .failure(let error):
                ErrorView(message: error, retryAction: {
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
