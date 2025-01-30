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
            switch viewModel.sections {
            case .loading:
                LoadingView()
            case .success(let sections):
                VStack {
                    List {
                        ForEach(sections.keys.sorted(), id: \.self) { key in
                            Section(header: Text(key).font(.headline)) {
                                if let countries = sections[key] {
                                    CountryListView(countries: countries)
                                } else {
                                    LoadingView()
                                }
                            }
                        }
                    }
                    
                    Button(action: viewModel.viewAllCountriesTapped) {
                        Text("View All Countries")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .contentShape(Rectangle())
                    .padding()
                }
            case .failure(let error):
                MessageView(message: error, retryAction: {
                    viewModel.retry()
                })
            }
        }
        .navigationTitle("Home")
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
