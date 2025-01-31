//
//  HomeInteractor.swift
//  CountriesApp
//
//  Created by Ahmed Elmansy on 31/01/2025.
//

import Foundation
import CountryDataService

protocol HomeInteractor {
    func getSections() async throws -> [String: [Country]]
}
