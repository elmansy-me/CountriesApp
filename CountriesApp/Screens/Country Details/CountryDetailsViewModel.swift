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
            await MainActor.run { [weak self] in
                self?.country = .success(
                    CountryDetailsViewItem(
                        name: country.name,
                        flagURL: country.flags?["png"] ?? "",
                        currency: (country.currencies ?? []).map { currency in
                            [currency.name + "(\(currency.symbol))"].joined(separator: " ")
                        }.joined(separator: ", "),
                        capital: country.capital ?? ""
                    )
                )
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
    
}
