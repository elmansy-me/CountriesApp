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
    let navigationCoordinator = NavigationCoordinator()

    func start() -> some View {
        let repository = UserCountryRepositoryBuilder.build()
        let viewModel = HomeViewModel(
            repository: repository,
            coordinator: navigationCoordinator
        )
        let view = NavigationContainerView(
            coordinator: navigationCoordinator,
            rootView: HomeView(viewModel: viewModel)
        )
        return view
    }
}
