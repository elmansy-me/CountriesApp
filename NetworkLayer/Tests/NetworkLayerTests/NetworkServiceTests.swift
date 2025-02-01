//
//  NetworkServiceTests.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import NetworkLayer

final class NetworkServiceTests: XCTestCase {
    
    var urlProtocol: MockURLProtocol!
    var networkService: NetworkService!

    override func setUp() async throws {
        urlProtocol = MockURLProtocol()
        let session = MockURLSession(urlProtocol: urlProtocol).session
        networkService = NetworkServiceImpl(session: session)
    }

    override func tearDown() {
        urlProtocol = nil
        networkService = nil
    }

    func testRequest_Success() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let expectedResponse = "{\"message\": \"Success\"}".data(using: .utf8)!
            return (response, expectedResponse)
        }

        let response = try await networkService.request(MockAPIRequest(), responseType: TestResponse.self)
        
        XCTAssertEqual(response.message, "Success")
    }

    func testRequest_StatusCodeError() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, nil)
        }

        do {
            _ = try await networkService.request(MockAPIRequest())
            XCTFail("Should throw statusCode error")
        } catch {
            XCTAssertEqual(error, .statusCode(500))
        }
    }

    func testRequest_DecodingError() async {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let expectedResponse = "TypeMismatch".data(using: .utf8)!
            return (response, expectedResponse)
        }

        do {
            let _: TestResponse = try await networkService.request(MockAPIRequest(), responseType: TestResponse.self)
            XCTFail("Sohuld throw decodingError")
        } catch {
            if case .decodingError(_) = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Error is not decodingError")
            }
        }
    }
}

extension NetworkServiceTests {
    
    struct TestResponse: Codable {
        let message: String
    }
    
}
