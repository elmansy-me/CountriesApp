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
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        AsyncImageView(url: country.flagURL, placeholder: Image(systemName: "globe"), size: .init(width: 64, height: 64))
                        
                        Text(country.name)
                            .font(.largeTitle)
                            .bold()
                    }

                    Text("Currency: \(country.currency)")
                        .font(.body)

                    Text("Capital: \(country.capital)")
                        .font(.body)
                }
                .padding()
            case .failure(let error):
                MessageView(message: error, retryAction: {
                    viewModel.retry()
                })
            }
        }
        .navigationTitle("Country Details")
        .task {
            await viewModel.fetchCountry()
        }
    }
}
