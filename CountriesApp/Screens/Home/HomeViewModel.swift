//
//  HomeViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 29/01/2025.
//

import Foundation
import CountryDataService

@MainActor
class HomeViewModel: BaseViewModel {
    
    @Published var sections: RequestState<[String: [Country]]> = .loading
    
    private let interactor: HomeInteractor

    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func loadCountries() async {
        sections = .loading
        do {
            let fetchedSections = try await interactor.getSections()
            await MainActor.run { [weak self] in
                self?.sections = .success(fetchedSections)
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

    func searchButtonTapped() {
        let repository = CountryRepositoryBuilder.build()
        let viewModel = SearchViewModel(repository: repository)
        let view = SearchView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
    func viewAllCountriesTapped() {
        let repository = CountryRepositoryBuilder.build()
        let viewModel = AllCountriesViewModel(repository: repository)
        let view = AllCountriesView(viewModel: viewModel)
        coordinator?.push(view)
    }
}
