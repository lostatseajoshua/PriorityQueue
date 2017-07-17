//
//  PriorityTypeTests.swift
//  PriorityQueue
//
//  Created by Joshua Alvarado on 7/14/17.
//  Copyright © 2017 Joshua Alvarado. All rights reserved.
//

import XCTest
@testable import PriorityQueue

struct Qux: PriorityType {
    var priority: Priority
}

class PriorityTypeTests: XCTestCase {
    static var allTests = [
        (testPriorityTypeComparable, "testPriorityTypeComparable")
    ]

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testPriorityTypeComparable() {
        let high: Priority = .high
        let medium: Priority = .medium
        let low: Priority = .low

        XCTAssertTrue(high > medium)
        XCTAssertTrue(medium > low)
        XCTAssertTrue(high > low)
        XCTAssertTrue(low < high)
        XCTAssertTrue(low == low)
        XCTAssertFalse(medium == high)
    }
}
