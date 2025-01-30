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
    
    @Published var sections: RequestState<[String: [Country]]> = .loading
    
    private let repository: UserCountryRepository
    private let coordinator: NavigationCoordinator

    init(repository: UserCountryRepository, coordinator: NavigationCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func loadCountries() async {
        sections = .loading
        do {
            let userCountry = try await repository.getCountry()
            await MainActor.run { [weak self] in
                self?.addSection(for: "My Country", with: [userCountry])
            }
            
            let countries = try await repository.getStarredCountries()
            await MainActor.run { [weak self] in
                self?.addSection(for: "Starred", with: countries)
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.sections = .failure(error.localizedDescription)
            }
        }
    }
    
    func retry() {
        Task {
            await loadCountries()
        }
    }
    
    private func addSection(for key: String,with value: [Country]) {
        guard var data = sections.data else {
            sections = .success([key: value])
            return
        }
        guard !data.keys.contains(key) else {
            return
        }
        
        data[key] = value
        sections = .success(data)
    }
    
    func searchButtonTapped() {
        let repository = CountryRepositoryBuilder.build()
        let viewModel = SearchViewModel(repository: repository, coordinator: coordinator)
        let view = SearchView(viewModel: viewModel)
        coordinator.push(view)
    }
    
    func viewAllCountriesTapped() {
        let repository = CountryRepositoryBuilder.build()
        let viewModel = AllCountriesViewModel(repository: repository, coordinator: coordinator)
        let view = AllCountriesView(viewModel: viewModel)
        coordinator.push(view)
    }
    
}
