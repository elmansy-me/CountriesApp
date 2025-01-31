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
        let userCountryRepository = UserCountryRepositoryBuilder.build()
        let favoritesRepository = FavoritesRepositoryBuilder.build()
        let interactor = HomeInteractorImpl(
            userCountryRepository: userCountryRepository,
            favoritesRepository: favoritesRepository
        )
        let viewModel = HomeViewModel(interactor: interactor)
        let view = NavigationContainerView(
            coordinator: coordinator,
            rootView: HomeView(viewModel: viewModel)
        )
        return view
    }
}
