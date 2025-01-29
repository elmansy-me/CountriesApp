//
//  CountriesAppApp.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import SwiftUI
import CountryDataService

@main
struct CountriesAppApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = CountryRepositoryBuilder.build()
            let viewModel = HomeViewModel(countryRepository: repository)
            let homeView = HomeView(viewModel: viewModel)
            homeView
        }
    }
}
