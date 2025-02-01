//
//  CountryDetailsViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp


final class CountryDetailsViewModelTests: XCTestCase {
    
    var viewModel: CountryDetailsViewModel!
    var mockInteractor: MockCountryDetailsInteractor!

    override func setUp() async throws {
        mockInteractor = MockCountryDetailsInteractor()
        viewModel = await CountryDetailsViewModel(countryCode: "EG", interactor: mockInteractor)
    }

    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
    }

    func testFetchCountry_Success() async throws {
        let countryDetails = CountryDetailsViewItem(
            name: "Egypt",
            flagURL: "url",
            currencies: ["Egyptian Pound - EGP": "جنيه مصري"],
            capital: "Cairo"
        )
        mockInteractor.mockCountryDetails = countryDetails
        
        await viewModel.fetchCountry()
        
        switch await viewModel.country {
        case .success(let country):
            XCTAssertEqual(country.name, "Egypt")
            XCTAssertEqual(country.flagURL, "url")
            XCTAssertEqual(country.currencies, ["Egyptian Pound - EGP": "جنيه مصري"])
            XCTAssertEqual(country.capital, "Cairo")
        default:
            XCTFail("Invalid state")
        }
    }

    func testFetchCountry_Failure() async throws {
        mockInteractor.mockError = NSError(domain: "domain", code: 1)
        
        await viewModel.fetchCountry()
        
        switch await viewModel.country {
        case .failure(let errorMessage):
            XCTAssertNotNil(errorMessage)
        default:
            XCTFail("Invalid state")
        }
    }

    func testToggleStarStatus_Success() async throws {
        var isStarred: Bool = false
        
        isStarred = await viewModel.isStarred
        XCTAssertFalse(isStarred)
        
        await viewModel.toggleStarStatus()
        isStarred = await viewModel.isStarred
        XCTAssertTrue(isStarred)
        
        await viewModel.toggleStarStatus()
        isStarred = await viewModel.isStarred
        XCTAssertFalse(isStarred)
    }

    func testToggleStarStatus_Fails() async throws {
        mockInteractor.mockError = NSError(domain: "domain", code: 1)
        
        await viewModel.toggleStarStatus()
        
        let isStarred = await viewModel.isStarred
        XCTAssertFalse(isStarred)
    }

    func testRetry_Success() async throws {
        let countryDetails = CountryDetailsViewItem(
            name: "Egypt",
            flagURL: "egypt_flag_url",
            currencies: ["Egyptian Pound - EGP": "جنيه مصري"],
            capital: "Cairo"
        )
        mockInteractor.mockCountryDetails = countryDetails
        
        await viewModel.retry()
        try await Task.sleep(nanoseconds: 250_000_000)
        
        switch await viewModel.country {
        case .success(let country):
            XCTAssertEqual(country.name, "Egypt")
        default:
            XCTFail("Invalid state")
        }
    }
}
