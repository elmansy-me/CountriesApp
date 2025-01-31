//
//  CountryListView.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

struct CountryListView: View {
    
    @ObservedObject var viewModel: CountryListViewModel
    @EnvironmentObject var coordinator: NavigationCoordinator
    let rightView: RightView?

    init(countries: [Country], rightView: RightView? = nil) {
        self.viewModel = CountryListViewModel(countries: countries)
        self.rightView = rightView
    }

    var body: some View {
        ForEach(viewModel.countries, id: \.name) { country in
            ZStack {
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
                    .background(.black.opacity(0.00001))
                }
                .buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())
                
                HStack {
                    Spacer()
                    if let rightView = rightView {
                        rightView.view(country.countryCode)
                            .onTapGesture {
                                rightView.onTapGesture(country.countryCode)
                            }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            viewModel.provideCoordinator(coordinator)
        }
    }
}



extension CountryListView {
    
    struct RightView {
        let view: (String) -> AnyView
        let onTapGesture: (String) -> Void
    }
    
}
