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
            let userCountry = try await userCountryRepository.getCountry()
            countries.append(userCountry)
            sections.append(.init(title: "My Country", countries: [userCountry]))
        } catch {
            throw error
        }

        do {
            let starredCountries = try favoritesRepository.getStarredCountries()
            if !starredCountries.isEmpty {
                countries.append(contentsOf: starredCountries)
                sections.append(.init(title: "Starred", countries: starredCountries))
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
    
    public func isStarred(countryCode: String) -> Bool {
        return (try? favoritesRepository.isStarred(countryCode: countryCode)) ?? false
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
