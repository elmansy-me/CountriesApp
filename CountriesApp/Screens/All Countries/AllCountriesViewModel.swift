//
//  AllCountriesViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import CountryDataService

@MainActor
class AllCountriesViewModel: ObservableObject {
    
    @Published var allCountries: RequestState<[Country]> = .loading
    
    private let repository: CountryRepository
    private let coordinator: NavigationCoordinator

    init(repository: CountryRepository, coordinator: NavigationCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func loadCountries() async {
        allCountries = .loading
        do {
            let countries = try await repository.fetchCountries()
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
        let repository = CountryRepositoryBuilder.build()
        let viewModel = SearchViewModel(repository: repository, coordinator: coordinator)
        let view = SearchView(viewModel: viewModel)
        coordinator.push(view)
    }
    
}
