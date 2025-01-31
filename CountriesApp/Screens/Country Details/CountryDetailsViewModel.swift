//
//  CountryDetailsViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import Combine

@MainActor
class CountryDetailsViewModel: ObservableObject {
    private let countryCode: String
    private let interactor: CountryDetailsInteractor

    @Published var country: RequestState<CountryDetailsViewItem> = .loading
    @Published var isStarred = false

    init(countryCode: String, interactor: CountryDetailsInteractor) {
        self.countryCode = countryCode
        self.interactor = interactor
        self.isStarred = interactor.isStarred(countryCode: countryCode)
    }

    func fetchCountry() async {
        country = .loading
        do {
            let countryDetails = try await interactor.fetchCountryDetails(countryCode: countryCode)
            await MainActor.run { [weak self] in
                self?.country = .success(countryDetails)
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.country = .failure(error.localizedDescription)
            }
        }
    }

    func toggleStarStatus() {
        do {
            try interactor.toggleStar()
            isStarred = interactor.isStarred(countryCode: countryCode)
        } catch {
            print("❌ Failed to toggle star: \(error)")
        }
    }

    func retry() {
        Task {
            await fetchCountry()
        }
    }
}

