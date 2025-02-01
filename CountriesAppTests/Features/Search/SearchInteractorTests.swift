//
//  SearchInteractorTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class SearchInteractorTests: XCTestCase {
    
    var interactor: SearchInteractorImpl!
    var mockRepository: MockCountryRepository!

    override func setUp() async throws {
        mockRepository = MockCountryRepository()
        interactor = SearchInteractorImpl(repository: mockRepository)
    }

    override func tearDown() {
        interactor = nil
        mockRepository = nil
    }

    func testFetchCountries_Success() async throws {
        let country = Country(name: "Egypt", flags: ["png": "url"], alpha2Code: "EG")
        mockRepository.mockCountries = [country]
        
        let result = try await interactor.fetchCountries()
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Egypt")
        XCTAssertEqual(result.first?.flagURL, "url")
        XCTAssertEqual(result.first?.countryCode, "EG")
    }

    func testFetchCountries_EmptyList() async throws {
        mockRepository.mockCountries = []
        
        let result = try await interactor.fetchCountries()
        
        XCTAssertEqual(result.count, 0)
    }

    func testFetchCountries_Failure() async throws {
        mockRepository.mockError = NSError(domain: "domain", code: 1)
        
        do {
            _ = try await interactor.fetchCountries()
            XCTFail("Invalid state")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testSearch_ValidQuery_FindsResults() {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG"),
            CountryListItem(name: "Saudi Arabia", flagURL: "url", countryCode: "SA")
        ]
        
        let result = interactor.search(query: "Egypt", allCountries: countries)
        
        XCTAssertEqual(result?.count, 1)
        XCTAssertEqual(result?.first?.name, "Egypt")
    }

    func testSearch_EmptyQuery_ReturnsEmptyArray() {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        ]
        
        let result = interactor.search(query: "", allCountries: countries)
        
        XCTAssertEqual(result?.count, 0)
    }

    func testSearch_NoMatchingResults_ReturnsNil() {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        ]
        
        let result = interactor.search(query: "Saudi Arabia", allCountries: countries)
        
        XCTAssertNil(result)
    }
}
