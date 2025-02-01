//
//  HomeViewModelTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockInteractor: MockHomeInteractor!

    override func setUp() async throws {
        mockInteractor = MockHomeInteractor()
        viewModel = await HomeViewModel(interactor: mockInteractor)
    }

    override func tearDown() {
        viewModel = nil
        mockInteractor = nil
    }

    func testLoadCountries_Success() async {
        let section = HomeViewSectionItem(title: "My Country", countries: [
            CountryListItem(name: "Egypt", flagURL: nil, countryCode: "EG")
        ])
        mockInteractor.mockSections = [section]
        
        await viewModel.loadCountries()
        try? await Task.sleep(nanoseconds: 250_000_000)
        
        switch await viewModel.sections {
        case .success(let sections):
            XCTAssertEqual(sections.count, 1)
            XCTAssertEqual(sections.first?.title, "My Country")
            XCTAssertEqual(sections.first?.countries.count, 1)
            XCTAssertEqual(sections.first?.countries.first?.name, "Egypt")
        default:
            XCTFail("Invalid sections state")
        }
    }

    func testLoadCountries_Failure() async {
        mockInteractor.mockError = NSError(domain: "Domain", code: 1)
        
        await viewModel.loadCountries()
        
        switch await viewModel.sections {
        case .failure(let errorMessage):
            XCTAssertNotNil(errorMessage)
        default:
            XCTFail("Invalid sections state")
        }
    }

    func testRetry_CallsLoadCountries() async {
        let section = HomeViewSectionItem(title: "My Country", countries: [])
        mockInteractor.mockSections = [section]
        
        await viewModel.retry()
        try? await Task.sleep(nanoseconds: 250_000_000)
        
        switch await viewModel.sections {
        case .success(let sections):
            XCTAssertEqual(sections.count, 1)
        default:
            XCTFail("Invalid sections state")
        }
    }

    func testToggleStarStatus_StarsCountry() async {
        mockInteractor.starredCountries.removeAll()
        
        let countryCode = "EG"
        
        await viewModel.toggleStarStatus(countryCode: countryCode)
        try? await Task.sleep(nanoseconds: 250_000_000)
        
        let isStarred = mockInteractor.isStarred(countryCode: countryCode)
        XCTAssertTrue(isStarred)
    }

    func testToggleStarStatus_UnstarsCountry() async {
        let countryCode = "EG"
        mockInteractor.starredCountries.insert(countryCode)
        
        await viewModel.toggleStarStatus(countryCode: countryCode)
        try? await Task.sleep(nanoseconds: 250_000_000)
        
        XCTAssertFalse(mockInteractor.isStarred(countryCode: countryCode))
    }

    func testIsStarred_ReturnsTrue() async {
        let countryCode = "EG"
        mockInteractor.starredCountries.insert(countryCode)
        
        let isStarred = await viewModel.isStarred(countryCode: countryCode)
        XCTAssertTrue(isStarred)
    }

    func testIsStarred_ReturnsFalse() async {
        let countryCode = "invalidCountryCode"
        
        let isStarred = await viewModel.isStarred(countryCode: countryCode)
        XCTAssertFalse(isStarred)
    }
}
