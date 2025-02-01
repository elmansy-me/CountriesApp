//
//  SearchView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            switch viewModel.countries {
            case .loading:
                LoadingView()
            case .success(let list):
                if let list {
                    if list.isEmpty {
                        MessageView(icon: .search, message: "Please enter your keyword")
                        Spacer()
                    } else {
                        List {
                            Section(header: Text("\(list.count) results").font(.headline)) {
                                CountryListView(countries: list)
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                } else {
                    MessageView(message: "Oops! We couldn't find any results matching your search")
                    Spacer()
                }
            case .failure(let error):
                MessageView(message: error, actions: [(.retry {
                    viewModel.retry()
                })])
            }
        }
        .task {
            await viewModel.loadCountries()
        }
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
    }
}
