//
//  SearchViewModel.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 30/01/2025.
//

import Foundation
import Combine
import CountryDataService

@MainActor
class SearchViewModel: ObservableObject {
    
    private var allCountries: [Country] = []
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var countries: RequestState<[Country]?> = .success([])
    @Published var query: String = ""
    
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
        bind()
    }
    
    func loadCountries() async {
        countries = .loading
        do {
            let countries = try await repository.fetchCountries()
            await MainActor.run { [weak self] in
                self?.allCountries = countries
            }
        } catch {
            await MainActor.run { [weak self] in
                self?.allCountries = []
                self?.countries = .failure(error.localizedDescription)
            }
        }
    }
    
    func retry() {
        Task {
            await loadCountries()
        }
    }
    
    private func bind() {
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: search)
            .store(in: &cancellables)
    }
    
    private func search(query: String) {
        guard !query.isEmpty else {
            countries = .success([])
            return
        }
        let lowercasedQuery = query.lowercased()
        let result = allCountries.filter {
            $0.name.lowercased().contains(lowercasedQuery)
        }
        if result.isEmpty {
            countries = .success(nil)
        } else {
            countries = .success(result)
        }
    }
    
}
