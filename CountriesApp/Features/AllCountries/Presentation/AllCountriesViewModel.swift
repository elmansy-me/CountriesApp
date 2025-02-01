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
    
    @Published var allCountries: RequestState<[CountryListItem]> = .loading
    
    private let interactor: AllCountriesInteractor

    init(interactor: AllCountriesInteractor) {
        self.interactor = interactor
    }
    
    func loadCountries() async {
        let data = allCountries.data ?? []
        guard data.isEmpty else { return }
        
        allCountries = .loading
        do {
            let countries = try await interactor.fetchCountries()
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
        let interactor = SearchInteractorImpl(repository: repository)
        let viewModel = SearchViewModel(interactor: interactor)
        let view = SearchView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
}
