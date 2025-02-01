//
//  DatabaseErrorTests.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import DatabaseKit

final class DatabaseErrorTests: XCTestCase {
    
    func testDatabaseError_Equals_DataNotFound() {
        XCTAssertEqual(DatabaseError.dataNotFound, DatabaseError.dataNotFound)
    }

    func testDatabaseError_Equals_EncodingFailed_SameError() {
        let error1 = DatabaseError.encodingFailed(NSError(domain: "Domain", code: 1))
        let error2 = DatabaseError.encodingFailed(NSError(domain: "Domain", code: 1))
        
        XCTAssertEqual(error1, error2)
    }
    
    func testDatabaseError_NotEquals_EncodingFailed_DifferentError() {
        let error1 = DatabaseError.encodingFailed(NSError(domain: "Domain 1", code: 1))
        let error2 = DatabaseError.encodingFailed(NSError(domain: "Domain 2", code: 2))
        
        XCTAssertNotEqual(error1, error2)
    }

    func testDatabaseError_Equals_DecodingFailed_SameError() {
        let error1 = DatabaseError.decodingFailed(NSError(domain: "Domain", code: 1))
        let error2 = DatabaseError.decodingFailed(NSError(domain: "Domain", code: 1))
        
        XCTAssertEqual(error1, error2)
    }
    
    func testDatabaseError_NotEquals_DecodingFailed_DifferentError() {
        let error1 = DatabaseError.decodingFailed(NSError(domain: "Domain 1", code: 1))
        let error2 = DatabaseError.decodingFailed(NSError(domain: "Domain 2", code: 2))
        
        XCTAssertNotEqual(error1, error2)
    }

    func testDatabaseError_NotEquals_MixedErrors() {
        XCTAssertNotEqual(
            DatabaseError.dataNotFound,
            DatabaseError.encodingFailed(NSError(domain: "Domain", code: 1))
        )
        XCTAssertNotEqual(
            DatabaseError.dataNotFound,
            DatabaseError.decodingFailed(NSError(domain: "Domain", code: 1))
        )
        XCTAssertNotEqual(
            DatabaseError.encodingFailed(NSError(domain: "Domain", code: 1)),
            DatabaseError.decodingFailed(NSError(domain: "Domain", code: 2))
        )
    }
}


