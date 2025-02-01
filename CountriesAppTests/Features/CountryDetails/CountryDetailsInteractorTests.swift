//
//  CountryDetailsInteractorTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class CountryDetailsInteractorTests: XCTestCase {
    
    var interactor: CountryDetailsInteractorImpl!
    var mockCountryRepository: MockCountryRepository!
    var mockFavoritesRepository: MockFavoritesRepository!

    override func setUp() async throws {
        mockCountryRepository = MockCountryRepository()
        mockFavoritesRepository = MockFavoritesRepository()
        interactor = CountryDetailsInteractorImpl(
            countryRepository: mockCountryRepository,
            favoritesRepository: mockFavoritesRepository
        )
    }

    override func tearDown() {
        interactor = nil
        mockCountryRepository = nil
        mockFavoritesRepository = nil
    }

    func testFetchCountryDetails_Success() async throws {
        let country = Country(
            name: "Egypt",
            capital: "Cairo",
            currencies: [Currency(code: "EGP", name: "Egyptian Pound", symbol: "جنيه مصري")],
            flags: ["png": "url"],
            alpha2Code: "EG"
        )
        mockCountryRepository.mockCountry = country
        
        let result = try await interactor.fetchCountryDetails(countryCode: "EG")
        
        XCTAssertEqual(result.name, "Egypt")
        XCTAssertEqual(result.flagURL, "url")
        XCTAssertEqual(result.currencies, ["Egyptian Pound - EGP": "جنيه مصري"])
        XCTAssertEqual(result.capital, "Cairo")
    }

    func testFetchCountryDetails_Failure() async throws {
        mockCountryRepository.mockError = NSError(domain: "domain", code: 1)
        
        do {
            _ = try await interactor.fetchCountryDetails(countryCode: "EG")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testToggleStar_Success() async throws {
        let country = Country(
            name: "Egypt",
            capital: "Cairo",
            currencies: [Currency(code: "EGP", name: "Egyptian Pound", symbol: "جنيه مصري")],
            flags: ["png": "url"],
            alpha2Code: "EG"
        )
        mockCountryRepository.mockCountry = country
        
        _ = try await interactor.fetchCountryDetails(countryCode: "EG")
        
        XCTAssertNoThrow(try interactor.toggleStar())
    }

    func testToggleStar_WithoutFetchingCountry_ShouldThrowError() throws {
        do {
            try interactor.toggleStar()
            XCTFail("Invalid state")
        } catch let error as CountryDetailsInteractorImpl.CountryDetailsError {
            XCTAssertEqual(error, .countryNotLoaded)
        } catch {
            XCTFail("Invalid error")
        }
    }

    func testIsStarred_CountryIsStarred() {
        mockFavoritesRepository.starredCountries = [.init(alpha2Code: "EG")]
        
        let result = interactor.isStarred(countryCode: "EG")
        
        XCTAssertTrue(result)
    }

    func testIsStarred_CountryIsNotStarred() {
        mockFavoritesRepository.starredCountries = []
        
        let result = interactor.isStarred(countryCode: "EG")
        
        XCTAssertFalse(result)
    }
}
