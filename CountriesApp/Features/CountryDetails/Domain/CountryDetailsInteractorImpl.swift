//
//  CountryDetailsInteractorImpl.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import CountryDataService

class CountryDetailsInteractorImpl: CountryDetailsInteractor {
    private let countryRepository: CountryRepository
    private let favoritesRepository: FavoritesRepository
    
    private var country: Country?

    public init(countryRepository: CountryRepository, favoritesRepository: FavoritesRepository) {
        self.countryRepository = countryRepository
        self.favoritesRepository = favoritesRepository
    }

    public func fetchCountryDetails(countryCode: String) async throws -> CountryDetailsViewItem {
        let country = try await countryRepository.fetchCountry(countryCode: countryCode)
        self.country = country
        return mapToViewItem(country)
    }

    public func toggleStar() throws {
        guard let country else {
            throw CountryDetailsError.countryNotLoaded
        }
        try favoritesRepository.toggleStar(for: country)
    }

    public func isStarred(countryCode: String) -> Bool {
        return (try? favoritesRepository.isStarred(countryCode: countryCode)) ?? false
    }

    private func mapToViewItem(_ country: Country) -> CountryDetailsViewItem {
        return CountryDetailsViewItem(
            name: country.name,
            flagURL: country.flags?["png"] ?? "",
            currencies: (country.currencies ?? []).reduce(into: [String: String]()) { dict, currency in
                dict["\(currency.name) - \(currency.code)"] = currency.symbol
            },
            capital: country.capital ?? "No capital available"
        )
    }
}

extension CountryDetailsInteractorImpl {
    
    enum CountryDetailsError: Error, LocalizedError {
        case countryNotLoaded
        
        var errorDescription: String {
            switch self {
            case .countryNotLoaded:
                return "Country details not loaded yet, please try again later."
            }
        }
    }
    
}
