//
//  HomeView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    
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
                        ForEach(sections, id: \.title) { section in
                            Section(header: Text(section.title).font(.headline)) {
                                CountryListView(countries: section.countries, rightView: .init(view: { countryCode in
                                    AnyView(
                                        Image(systemName: viewModel.isStarred(countryCode: countryCode) ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                    )
                                }, onTapGesture: { countryCode in
                                    viewModel.toggleStarStatus(countryCode: countryCode)
                                }))
                            }
                        }
                    }
                    
                    Button(action: viewModel.viewAllCountriesTapped) {
                        Text("View All Countries")
                            .font(.headline)
                            .foregroundColor(Color(.systemBackground))
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(.primary)
                            .cornerRadius(8)
                    }
                    .contentShape(Rectangle())
                    .padding()
                }
            case .failure(let error):
                MessageView(message: error, actions: [(.retry {
                    viewModel.retry()
                })])
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
        .onAppear {
            viewModel.provideCoordinator(coordinator)
        }
        .task {
            await viewModel.loadCountries()
        }
    }
}
