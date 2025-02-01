//
//  UserDefaultsDatabaseTests.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import XCTest
@testable import DatabaseKit

final class UserDefaultsDatabaseTests: XCTestCase {
    
    private var database: UserDefaultsDatabase!
    private var mockDefaults: MockUserDefaults!
    private let testKey = "key"
    
    override func setUp() {
        super.setUp()
        mockDefaults = MockUserDefaults()
        database = UserDefaultsDatabase(userDefaults: mockDefaults)
    }
    
    override func tearDown() {
        mockDefaults.clear()
        super.tearDown()
    }
    
    func testSaveAndRetrieveObject_Success() throws {
        let testObject = TestModel(id: 1, name: "Test")
        
        XCTAssertNoThrow(try database.save(testObject, forKey: testKey))
        let retrievedObject: TestModel = try database.get(forKey: testKey, as: TestModel.self)
        
        XCTAssertEqual(retrievedObject, testObject)
    }
    
    func testGetObject_DataNotFound() {
        XCTAssertThrowsError(try database.get(forKey: testKey, as: String.self)) { error in
            XCTAssertEqual(error as? DatabaseError, .dataNotFound)
        }
    }
    
    func testSaveObject_EncodingFailure() {
        let invalidObject = BrokenEncodableModel(name: "Test")
        
        XCTAssertThrowsError(try database.save(invalidObject, forKey: testKey)) { error in
            guard case DatabaseError.encodingFailed(_) = error else {
                return XCTFail("Expected encodingFailed error")
            }
        }
    }
    
    func testGetObject_DecodingFailure() {
        let invalidData = "Invalid Content".data(using: .utf8)!
        mockDefaults.set(invalidData, forKey: testKey)
        
        XCTAssertThrowsError(try database.get(forKey: testKey, as: Int.self)) { error in
            guard case DatabaseError.decodingFailed(_) = error else {
                return XCTFail("Expected decodingFailed error")
            }
        }
    }
    
    func testRemoveObject_Success() throws {
        try database.save("Test Data", forKey: testKey)
        
        database.remove(forKey: testKey)
        
        XCTAssertThrowsError(try database.get(forKey: testKey, as: String.self)) { error in
            XCTAssertEqual(error as? DatabaseError, .dataNotFound)
        }
    }
    
    func testClearAll_Success() throws {
        try database.save("Value1", forKey: "key1")
        try database.save("Value2", forKey: "key2")
        
        database.clearAll()
        
        XCTAssertThrowsError(try database.get(forKey: "key1", as: String.self))
        XCTAssertThrowsError(try database.get(forKey: "key2", as: String.self))
    }
}


extension UserDefaultsDatabaseTests {
    
    struct TestModel: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    struct BrokenEncodableModel: Codable {
        let name: String
        
        func encode(to encoder: Encoder) throws {
            throw NSError(domain: "EncodingError", code: 0, userInfo: nil)
        }
    }
    
}
