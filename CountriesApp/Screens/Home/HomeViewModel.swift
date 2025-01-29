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

    init(countryRepository: CountryRepository) {
        self.countryRepository = countryRepository
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
    
}
