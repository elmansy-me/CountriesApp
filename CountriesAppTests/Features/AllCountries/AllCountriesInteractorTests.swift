//
//  AllCountriesInteractorTests.swift
//  CountriesAppTests
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import CountriesApp
@testable import CountryDataService

final class AllCountriesInteractorTests: XCTestCase {
    
    var interactor: AllCountriesInteractorImpl!
    var mockRepository: MockCountryRepository!

    override func setUp() async throws {
        mockRepository = MockCountryRepository()
        interactor = AllCountriesInteractorImpl(repository: mockRepository)
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
        mockRepository.mockError = NSError(domain: "Domain", code: 1)
        
        do {
            _ = try await interactor.fetchCountries()
            XCTFail("Invalid state")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
