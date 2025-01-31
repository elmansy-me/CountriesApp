//
//  CountryDetailsView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI
import CountryDataService

struct CountryDetailsView: View {
    @StateObject private var viewModel: CountryDetailsViewModel
    
    init(viewModel: CountryDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.country {
            case .loading:
                LoadingView()
            case .success(let country):
                VStack(spacing: 20) {
                    flagHeader(country)
                    List {
                        capitalSection(title: "Capital", value: country.capital, icon: "building.columns.fill")
                        currencySection(title: "Currencies", values: country.currencies)
                    }
                    .background(Color.red)
                    .scrollDisabled(true)
                    Spacer()
                }
                .padding(6)
                .ignoresSafeArea(edges: .top)
            case .failure(let error):
                MessageView(message: error, retryAction: {
                    viewModel.retry()
                })
            }
        }
        .navigationTitle("Country Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.toggleStarStatus ) {
                    Image(systemName: viewModel.isStarred ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
        .task {
            await viewModel.fetchCountry()
        }
    }
    
    @ViewBuilder
    private func flagHeader(_ country: CountryDetailsViewItem) -> some View {
        VStack {
            AsyncImageView(url: country.flagURL, placeholder: Image(systemName: "globe"), size: .init(width: 120, height: 80))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
            
            Text(country.name)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 50)
    }
    
    @ViewBuilder
    private func capitalSection(title: String, value: String, icon: String) -> some View {
        Section(header: Text(title).font(.headline)) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.vertical, 12)
        }
    }
    
    @ViewBuilder
    private func currencySection(title: String, values: [String: String]) -> some View {
        Section(header: Text(title).font(.headline)) {
            ForEach(values.keys.sorted(), id: \.self) { key in
                HStack {
                    Text(key)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if let symbol = values[key] {
                        Text(symbol)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
    
}
