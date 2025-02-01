//
//  AllCountriesView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct AllCountriesView: View {
    
    @ObservedObject private var viewModel: AllCountriesViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    init(viewModel: AllCountriesViewModel) {
        self.viewModel = viewModel
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
                MessageView(message: error, actions: [.retry {
                    viewModel.retry()
                }])
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
        .onAppear {
            viewModel.provideCoordinator(coordinator)
        }
        .task {
            await viewModel.loadCountries()
        }
    }
}
