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
    
    @Published var sections: RequestState<[HomeViewSectionItem]> = .loading
    
    private let interactor: HomeInteractor

    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func loadCountries() async {
        sections = .loading
        do {
            let sections = try await interactor.getSections()
            await MainActor.run { [weak self] in
                self?.sections = .success(sections)
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
    
    func toggleStarStatus(countryCode: String) {
        Task {
            do {
                let sections = try await interactor.toggleStar(countryCode: countryCode)
                await MainActor.run { [weak self] in
                    self?.sections = .success(sections)
                }
            } catch {
                let view = PopupView(message: error.localizedDescription, actions: [(.close(action: { [weak self] in
                    self?.coordinator?.goBack()
                }))])
                coordinator?.presentPopup(view)
            }
        }
    }
    
    func isStarred(countryCode: String) -> Bool {
        interactor.isStarred(countryCode: countryCode)
    }

    func searchButtonTapped() {
        let repository = CountryRepositoryBuilder.build()
        let interactor = SearchInteractorImpl(repository: repository)
        let viewModel = SearchViewModel(interactor: interactor)
        let view = SearchView(viewModel: viewModel)
        coordinator?.push(view)
    }
    
    func viewAllCountriesTapped() {
        let repository = CountryRepositoryBuilder.build()
        let interactor = AllCountriesInteractorImpl(repository: repository)
        let viewModel = AllCountriesViewModel(interactor: interactor)
        let view = AllCountriesView(viewModel: viewModel)
        coordinator?.push(view)
    }
}
