//
//  NetworkErrorTests.swift
//  NetworkLayer
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import NetworkLayer

final class NetworkErrorTests: XCTestCase {
    
    func testInvalidURLError() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(error.localizedDescription, "URL is invalid.")
        XCTAssertEqual(error, .invalidURL)
    }
    
    func testNoResponseError() {
        let error = NetworkError.noResponse
        XCTAssertEqual(error.localizedDescription, "No response received from the server.")
        XCTAssertEqual(error, .noResponse)
    }
    
    func testStatusCodeError() {
        let error = NetworkError.statusCode(404)
        XCTAssertEqual(error.localizedDescription, "Request failed with status code: 404")
        XCTAssertEqual(error, .statusCode(404))
        XCTAssertNotEqual(error, .statusCode(400))
    }
    
    func testDecodingError() {
        let sampleError = NSError(domain: "Domain", code: 1, userInfo: nil)
        let error = NetworkError.decodingError(sampleError)
        
        XCTAssertEqual(error.errorDescription, "Failed to decode response: The operation couldn’t be completed. (Domain error 1.)")
        XCTAssertEqual(error, .decodingError(sampleError))
        
        let differentError = NSError(domain: "Domain", code: 2, userInfo: nil)
        XCTAssertNotEqual(error, .decodingError(differentError))
    }
    
    func testAPIError() {
        let apiError = APIErrorResponse(status: 404, message: "Not Found")
        let error = NetworkError.apiError(apiError)
        
        XCTAssertEqual(error.errorDescription, "Not Found (404)")
        XCTAssertEqual(error, .apiError(apiError))
        
        XCTAssertNotEqual(error, .apiError(.init(status: 401, message: "Unauthorized")))
    }
    
    func testUnknownError() {
        let sampleError = NSError(domain: "Domain", code: 1, userInfo: nil)
        let error = NetworkError.unknown(sampleError)
        
        XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (Domain error 1.)")
        XCTAssertEqual(error, .unknown(sampleError))
        
        XCTAssertNotEqual(error, .unknown(NSError(domain: "Domain", code: 2, userInfo: nil)))
    }
}
