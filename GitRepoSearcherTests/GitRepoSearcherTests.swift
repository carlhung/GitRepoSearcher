//
//  GitRepoSearcherTests.swift
//  GitRepoSearcherTests
//
//  Created by carlhung on 10/5/2021.
//

import XCTest
@testable import GitRepoSearcher

class GitRepoSearcherTests: XCTestCase {
    
    var itemArray: [Items]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        itemArray = []
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        XCTAssert(itemArray?.count == 0, "It should be 0.")
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(itemArray != nil, "itemArray is nil. But it shouldn't be.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
