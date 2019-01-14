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

    // MARK: - Task 2
    
    func testTask2_with_two_lifts() {
        let ticks = sut.calculateLiftTicks(floors: 4,
                                           maxPeople: 2,
                                           maxWeight: 200,
                                           weightArray: [60, 70, 80, 90],
                                           destinationArray: [2, 2, 3, 4],
                                           numberOfLifts: 2)
        XCTAssertEqual(ticks, 14)
    }
    
    func testTask2_with_two_lifts_but_only_one_needed() {
        let ticks = sut.calculateLiftTicks(floors: 4,
                                           maxPeople: 5,
                                           maxWeight: 600,
                                           weightArray: [60, 70, 80, 90],
                                           destinationArray: [2, 2, 3, 4],
                                           numberOfLifts: 2)
        XCTAssertEqual(ticks, 11)
    }
    
    func testTask2_with_one_lift_random_data() {
        let ticks = sut.calculateLiftTicks(floors: 4,
                                           maxPeople: 5,
                                           maxWeight: 200,
                                           weightArray: [60, 70, 80, 90],
                                           destinationArray: [2, 2, 3, 4],
                                           numberOfLifts: 1)
        XCTAssertEqual(ticks, 14)
    }
    
    // MARK: - Helpers

    func testCanEnter_should_enter_second() {
        
        let lift = sut.canEnter(person: 50, lifts: [[60], []], maxPeople: 2, maxWeight: 100)
        
        XCTAssertNotNil(lift)
        XCTAssertEqual(1, lift!)
    }
    
    func testCanEnter_should_enter_first() {
        
        let lift = sut.canEnter(person: 50, lifts: [[40], []], maxPeople: 2, maxWeight: 200)
        
        XCTAssertNotNil(lift)
        XCTAssertEqual(0, lift!)
    }
    
    func testCanEnter_cant_enter_any_lift() {
        
        let lift = sut.canEnter(person: 50, lifts: [[100], [90]], maxPeople: 1, maxWeight: 90)
        
        XCTAssertNil(lift)
    }
    
    
    func testQueueTicks_() {
        let queueTicks = sut.queueTicks([[40], []], destinations: [[2], []], floors: 3)
        
        XCTAssertEqual(4, queueTicks)
    }
    
}
