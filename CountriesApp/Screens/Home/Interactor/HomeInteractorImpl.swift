//
//  HomeInteractorImpl.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import CountryDataService

public class HomeInteractorImpl: HomeInteractor {
    private let userCountryRepository: UserCountryRepository
    private let favoritesRepository: FavoritesRepository

    public init(userCountryRepository: UserCountryRepository, favoritesRepository: FavoritesRepository) {
        self.userCountryRepository = userCountryRepository
        self.favoritesRepository = favoritesRepository
    }

    public func getSections() async throws -> [String: [Country]] {
        var sections: [String: [Country]] = [:]

        do {
            let userCountry = try await userCountryRepository.getCountry()
            sections["My Country"] = [userCountry]
        } catch {
            throw error
        }

        do {
            let starredCountries = try favoritesRepository.getStarredCountries()
            if !starredCountries.isEmpty {
                sections["Starred"] = starredCountries
            }
        } catch {
            throw error
        }

        return sections
    }
}
