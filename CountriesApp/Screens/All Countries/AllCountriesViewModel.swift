//
//  AllCountriesViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import CountryDataService

@MainActor
class AllCountriesViewModel: BaseViewModel {
    
    @Published var allCountries: RequestState<[Country]> = .loading
    
    private let repository: CountryRepository

    init(repository: CountryRepository) {
        self.repository = repository
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
        let viewModel = SearchViewModel(repository: repository)
        let view = SearchView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
}
