//
//  CountryDetailsViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import Combine
import CountryDataService

@MainActor
class CountryDetailsViewModel: ObservableObject {
    private let countryCode: String
    private let repository: CountryRepository
    
    @Published var country: RequestState<CountryDetailsViewItem> = .loading

    init(countryCode: String, repository: CountryRepository) {
        self.countryCode = countryCode
        self.repository = repository
    }

    func fetchCountry() async {
        country = .loading
        do {
            let country = try await repository.fetchCountry(countryCode: countryCode)
            let mappedCountry = mapToViewItem(country)
            
            await MainActor.run { [weak self] in
                self?.country = .success(mappedCountry)
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.country = .failure(error.localizedDescription)
            }
        }
    }
    
    func retry() {
        Task {
            await fetchCountry()
        }
    }
    
    private func mapToViewItem(_ country: Country) -> CountryDetailsViewItem {
        let name = country.name
        let flagURL = country.flags?["png"] ?? ""
        let currencies: [String: String] = {
            guard let currencies = country.currencies, !currencies.isEmpty else {
                return ["No currency available": ""]
            }
            
            return Dictionary(
                uniqueKeysWithValues: currencies
                    .map { (
                        $0.name + " - " + $0.code,
                        $0.symbol
                    )
                })
        }()
        let capital: String = {
            if let capital = country.capital, !capital.isEmpty {
                return capital
            }
            return "No capital available"
        }()
        return CountryDetailsViewItem(
            name: name,
            flagURL: flagURL,
            currencies: currencies,
            capital: capital
        )
    }
    
}
