//
//  HomeViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import CountryDataService

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var allCountries: RequestState<[Country]> = .loading
    
    private let countryRepository: CountryRepository
    private let coordinator: NavigationCoordinator

    init(countryRepository: CountryRepository, coordinator: NavigationCoordinator) {
        self.countryRepository = countryRepository
        self.coordinator = coordinator
    }

    func loadCountries() async {
        allCountries = .loading
        do {
            let countries = try await countryRepository.fetchCountries()
            await MainActor.run { [weak self] in
                self?.allCountries = .success(countries)
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.allCountries = .failure(error.localizedDescription)
            }
        }
    }
    
    func retry() {
        Task {
            await loadCountries()
        }
    }
    
    func searchButtonTapped() {
        guard let countries = allCountries.data else { return }
        let viewModel = SearchViewModel(coordinator: coordinator, allCountries: countries)
        let view = SearchView(viewModel: viewModel)
        coordinator.push(view)
    }
    
}
