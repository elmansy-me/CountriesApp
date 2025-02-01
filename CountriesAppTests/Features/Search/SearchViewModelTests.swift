//
//  SearchViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var mockInteractor: MockSearchInteractor!
    
    override func setUp() async throws {
        mockInteractor = MockSearchInteractor()
        viewModel = await SearchViewModel(interactor: mockInteractor)
    }
    
    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
    }
    
    func testLoadCountries_Success() async throws {
        let country = CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        mockInteractor.mockCountries = [country]
        
        await viewModel.loadCountries()
        
        switch await viewModel.countries {
        case .success(let countries):
            XCTAssertEqual(countries?.count, 0)
            let allCountries = await viewModel.allCountries
            XCTAssertEqual(allCountries.count, 1)
            XCTAssertEqual(allCountries.first?.name, "Egypt")
        default:
            XCTFail("Invalid state")
        }
    }
    
    func testLoadCountries_EmptyList() async throws {
        mockInteractor.mockCountries = []
        
        await viewModel.loadCountries()
        
        switch await viewModel.countries {
        case .success(let countries):
            XCTAssertEqual(countries?.count, 0)
            let allCountries = await viewModel.allCountries
            XCTAssertEqual(allCountries.count, 0)
        default:
            XCTFail("Invalid state")
        }
    }
    
    func testLoadCountries_Failure() async {
        mockInteractor.mockError = NSError(domain: "domain", code: 1)
        
        await viewModel.loadCountries()
        
        switch await viewModel.countries {
        case .failure(let errorMessage):
            XCTAssertNotNil(errorMessage)
        default:
            XCTFail("Invalid state")
        }
    }
    
    func testRetry_CallsLoadCountries() async throws {
        let country = CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        mockInteractor.mockCountries = [country]
        
        await viewModel.retry()
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch await viewModel.countries {
        case .success(let countries):
            XCTAssertEqual(countries?.count, 0)
            let allCountries = await viewModel.allCountries
            XCTAssertEqual(allCountries.count, 1)
        default:
            XCTFail("Expected success state after retry")
        }
    }
    
    func testSearch_ValidQuery_FindsResults() async throws {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG"),
            CountryListItem(name: "United States", flagURL: "us_flag_url", countryCode: "US")
        ]
        
        mockInteractor.mockCountries = countries
        await viewModel.loadCountries()
        
        await MainActor.run {
            viewModel.query = "Egypt"
        }
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch await viewModel.countries {
        case .success(let searchResults):
            XCTAssertEqual(searchResults?.count, 1)
            XCTAssertEqual(searchResults?.first?.name, "Egypt")
        default:
            XCTFail("Invalid state")
        }
    }
    
    func testSearch_NoMatchingResults_ReturnsNil() async throws {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        ]
        
        mockInteractor.mockCountries = countries
        await viewModel.loadCountries()
        
        await MainActor.run {
            viewModel.query = "Saudi Arabia"
        }
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch await viewModel.countries {
        case .success(let searchResults):
            XCTAssertNil(searchResults)
        default:
            XCTFail("Invalid state")
        }
    }
    
    func testSearch_EmptyQuery_ReturnsEmptyArray() async throws {
        let countries = [
            CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        ]
        
        mockInteractor.mockCountries = countries
        await viewModel.loadCountries()
        
        await MainActor.run {
            viewModel.query = ""
        }
        try await Task.sleep(nanoseconds: 500_000_000)
        
        switch await viewModel.countries {
        case .success(let searchResults):
            XCTAssertEqual(searchResults?.count, 0)
        default:
            XCTFail("Invalid state")
        }
    }
    
}
