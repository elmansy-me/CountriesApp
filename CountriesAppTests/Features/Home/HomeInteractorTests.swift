//
//  HomeInteractorTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class HomeInteractorTests: XCTestCase {
    
    var interactor: HomeInteractorImpl!
    var mockUserCountryRepository: MockUserCountryRepository!
    var mockFavoritesRepository: MockFavoritesRepository!

    override func setUp() async throws {
        mockUserCountryRepository = MockUserCountryRepository()
        mockFavoritesRepository = MockFavoritesRepository()
        interactor = HomeInteractorImpl(
            userCountryRepository: mockUserCountryRepository,
            favoritesRepository: mockFavoritesRepository
        )
    }

    override func tearDown() {
        interactor = nil
        mockUserCountryRepository = nil
        mockFavoritesRepository = nil
    }

    func testGetSections_Success() async throws {
        let country = Country(name: "Egypt", flags: ["png": "mock_url"], alpha2Code: "EG")
        mockUserCountryRepository.mockCountry = country
        
        let sections = try await interactor.getSections()
        
        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections.first?.title, "My Country")
        XCTAssertEqual(sections.first?.countries.count, 1)
        XCTAssertEqual(sections.first?.countries.first?.name, "Egypt")
    }

    func testGetSections_WithStarredCountries() async throws {
        let myCountry = Country(name: "Egypt",  alpha2Code: "EG")
        let starredCountry = Country(name: "Saudi Arabia", alpha2Code: "SA")
        
        mockUserCountryRepository.mockCountry = myCountry
        mockFavoritesRepository.starredCountries = [starredCountry]
        
        let sections = try await interactor.getSections()
        
        XCTAssertEqual(sections.count, 2)
        XCTAssertEqual(sections[0].title, "My Country")
        XCTAssertEqual(sections[0].countries.count, 1)
        XCTAssertEqual(sections[0].countries.first?.name, "Egypt")
        XCTAssertEqual(sections[1].title, "Starred")
        XCTAssertEqual(sections[1].countries.count, 1)
        XCTAssertEqual(sections[1].countries.first?.name, "Saudi Arabia")
    }

    func testToggleStar_Success() async throws {
        let country = Country(name: "Egypt",  alpha2Code: "EG")
        mockUserCountryRepository.mockCountry = country
        _ = try await interactor.getSections()
        
        let updatedSections = try await interactor.toggleStar(countryCode: "EG")
        XCTAssertEqual(updatedSections.count, 2)
        XCTAssertEqual(updatedSections[1].title, "Starred")
        XCTAssertEqual(updatedSections[1].countries.count, 1)
    }

    func testToggleStar_RemovesFromStarred() async throws {
        let country = Country(name: "Egypt",  alpha2Code: "EG")
        mockUserCountryRepository.mockCountry = country
        mockFavoritesRepository.starredCountries.append(country)
        
        _ = try await interactor.getSections()
        
        let updatedSections = try await interactor.toggleStar(countryCode: "EG")
        XCTAssertEqual(updatedSections.count, 1)
    }

    func testToggleStar_Failure_CountryNotFound() async throws {
        let myCountry = Country(name: "Egypt",  alpha2Code: "EG")
        mockUserCountryRepository.mockCountry = myCountry
        _ = try await interactor.getSections()
        
        do {
            _ = try await interactor.toggleStar(countryCode: "invalidCountryCode")
            XCTFail("Should throw countryNotFound error")
        } catch let error as HomeInteractorImpl.HomeError {
            XCTAssertEqual(error, .countryNotFound)
        }
    }

    func testIsStarred_ReturnsTrue() async throws {
        let country = Country(name: "Egypt",  alpha2Code: "EG")
        mockFavoritesRepository.starredCountries.append(country)
        
        let isStarred = interactor.isStarred(countryCode: "EG")
        XCTAssertTrue(isStarred)
    }

    func testIsStarred_ReturnsFalse() async throws {
        let isStarred = interactor.isStarred(countryCode: "EG")
        XCTAssertFalse(isStarred)
    }
}
