//
//  HomeInteractorImpl.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import CountryDataService

class HomeInteractorImpl: HomeInteractor {
    private let userCountryRepository: UserCountryRepository
    private let favoritesRepository: FavoritesRepository

    private var countries: [Country] = []
    
    public init(userCountryRepository: UserCountryRepository, favoritesRepository: FavoritesRepository) {
        self.userCountryRepository = userCountryRepository
        self.favoritesRepository = favoritesRepository
    }

    func getSections() async throws -> [HomeViewSectionItem] {
        var sections: [HomeViewSectionItem] = []
        countries.removeAll()
        
        do {
            let myCountry = try await userCountryRepository.getCountry()
            countries.append(myCountry)
            let mappedMyCountry = mapCountriesToListItems([myCountry])
            sections.append(.init(title: "My Country", countries: mappedMyCountry))
            
            let starredCountries = try favoritesRepository.getStarredCountries()
            if !starredCountries.isEmpty {
                countries.append(contentsOf: starredCountries)
                let mappedStarredCountries = mapCountriesToListItems(starredCountries)
                sections.append(.init(title: "Starred", countries: mappedStarredCountries))
            }
        } catch {
            throw error
        }

        return sections
    }
    
    func toggleStar(countryCode: String) async throws -> [HomeViewSectionItem] {
        guard let country = countries.first(where: { $0.countryCode == countryCode }) else {
            throw HomeError.countryNotFound
        }
        
        try favoritesRepository.toggleStar(for: country)
        let sections = try await getSections()
        return sections
    }
    
    func isStarred(countryCode: String) -> Bool {
        return (try? favoritesRepository.isStarred(countryCode: countryCode)) ?? false
    }
    
    private func mapCountriesToListItems(_ countries: [Country]) -> [CountryListItem] {
        countries.map({ country in
            CountryListItem(
                name: country.name,
                flagURL: country.flags?["png"],
                countryCode: country.countryCode
            )
        })
    }
    
}

extension HomeInteractorImpl {
    
    enum HomeError: Error, LocalizedError {
        case countryNotFound
        
        var errorDescription: String? {
            switch self {
            case .countryNotFound:
                return "Country not found"
            }
        }
    }
    
}
