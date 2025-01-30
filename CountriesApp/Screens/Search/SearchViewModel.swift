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
    
    private let allCountries: [Country]
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var countries: [Country]? = []
    @Published var query: String = ""
    
    private let coordinator: NavigationCoordinator
    
    init(coordinator: NavigationCoordinator, allCountries: [Country]) {
        self.coordinator = coordinator
        self.allCountries = allCountries
        bind()
    }
    
    private func bind() {
        $query
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: search)
            .store(in: &cancellables)
    }
    
    private func search(query: String) {
        guard !query.isEmpty else {
            countries = []
            return
        }
        let lowercasedQuery = query.lowercased()
        let result = allCountries.filter {
            $0.name.lowercased().contains(lowercasedQuery)
        }
        if result.isEmpty {
            countries = nil
        } else {
            countries = result
        }
    }
    
}
