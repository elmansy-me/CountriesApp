//
//  AllCountriesViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class AllCountriesViewModelTests: XCTestCase {
    
    var viewModel: AllCountriesViewModel!
    var mockInteractor: MockAllCountriesInteractor!

    override func setUp() async throws {
        mockInteractor = MockAllCountriesInteractor()
        viewModel = await AllCountriesViewModel(interactor: mockInteractor)
    }

    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
    }

    func testLoadCountries_Success() async throws {
        let country = CountryListItem(name: "Egypt", flagURL: "url", countryCode: "EG")
        mockInteractor.mockCountries = [country]
        
        await viewModel.loadCountries()
        
        switch await viewModel.allCountries {
        case .success(let countries):
            XCTAssertEqual(countries.count, 1)
            XCTAssertEqual(countries.first?.name, "Egypt")
            XCTAssertEqual(countries.first?.flagURL, "url")
            XCTAssertEqual(countries.first?.countryCode, "EG")
        default:
            XCTFail("Invalid state")
        }
    }

    func testLoadCountries_EmptyList() async throws {
        mockInteractor.mockCountries = []
        
        await viewModel.loadCountries()
        
        switch await viewModel.allCountries {
        case .success(let countries):
            XCTAssertEqual(countries.count, 0)
        default:
            XCTFail("Invalid state")
        }
    }

    func testLoadCountries_Failure() async throws {
        mockInteractor.mockError = NSError(domain: "domain", code: 1)
        
        await viewModel.loadCountries()
        
        switch await viewModel.allCountries {
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
        try? await Task.sleep(nanoseconds: 250_000_000)
        
        switch await viewModel.allCountries {
        case .success(let countries):
            XCTAssertEqual(countries.count, 1)
        default:
            XCTFail("Invalid state")
        }
    }
}
