//
//  AppCoordinator.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import SwiftUI
import CountryDataService

@MainActor
class AppCoordinator {

    func start(coordinator: NavigationCoordinator) -> some View {
        let repository = UserCountryRepositoryBuilder.build()
        let viewModel = HomeViewModel(
            repository: repository
        )
        let view = NavigationContainerView(
            coordinator: coordinator,
            rootView: HomeView(viewModel: viewModel)
        )
        return view
    }
}
