//
//  UrbanThingsTests.swift
//  UrbanThingsTests
//
//  Created by Alexander on 06/01/2019.
//  Copyright © 2019 alexanderludvigs. All rights reserved.
//

import XCTest
@testable import UrbanThings

class UrbanThingsTests: XCTestCase {
    
    var sut: ViewController!
    
    override func setUp() {
        sut = ViewController()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testTask1_1() {
        let ticks = sut.calculateLiftTicks(floors: 5,
                                maxPeople: 2,
                                maxWeight: 200,
                                weightArray: [60, 80, 40],
                                destinationArray: [2, 3, 2])
        
        XCTAssertEqual(ticks, 12)
    }
    
    func testTask1_2() {
        let ticks = sut.calculateLiftTicks(floors: 5,
                                           maxPeople: 3,
                                           maxWeight: 100,
                                           weightArray: [60, 80, 40],
                                           destinationArray: [2, 3, 4])
        
        XCTAssertEqual(ticks, 13)
    }
    
    func testTask1_weightArray_and_destinationArray_not_same_count() {
        let ticks = sut.calculateLiftTicks(floors: 5,
                                           maxPeople: 3,
                                           maxWeight: 300,
                                           weightArray: [60, 80, 40, 50],
                                           destinationArray: [2, 3])
        // weight array and destination
        // array do not have the same count
        XCTAssertEqual(ticks, 0)
    }
    
    func testTask1_max_people_zero() {
        let ticks = sut.calculateLiftTicks(floors: 5,
                                           maxPeople: 0,
                                           maxWeight: 300,
                                           weightArray: [60, 80, 40, 50],
                                           destinationArray: [2, 3])
        
        XCTAssertEqual(ticks, 0)
    }
    
    // MARK: - canEnterQueue()
    
    func testCanEnterQueue1() {
        
        
    }
}
