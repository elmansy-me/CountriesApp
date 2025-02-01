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
    
    private var allCountries: [CountryListItem] = []
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var countries: RequestState<[CountryListItem]?> = .success([])
    @Published var query: String = ""
    
    private let interactor: SearchInteractor

    init(interactor: SearchInteractor) {
        self.interactor = interactor
        bind()
    }
    
    func loadCountries() async {
        guard allCountries.isEmpty else { return }
        
        countries = .loading
        do {
            let countries = try await interactor.fetchCountries()
            await MainActor.run { [weak self] in
                self?.allCountries = countries
                self?.countries = .success([])
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
        guard !allCountries.isEmpty else { return }
        let result = interactor.search(query: query, allCountries: allCountries)
        countries = .success(result)
    }
}
