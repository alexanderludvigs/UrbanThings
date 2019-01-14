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
    
    func testCalculateLiftTicks_random_data() {
        let ticks = sut.calculateLiftTicks(floors: 5,
                                maxPeople: 2,
                                maxWeight: 200,
                                weightArray: [60, 80, 40],
                                destinationArray: [2, 3, 2])
        
        XCTAssertEqual(ticks, 12)
    }
    
    func testCalculateLiftTicks_random_data2() {
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
    
    // MARK: - canEnterQueue(..)
    
    func testCanEnterQueue_can_enter() {
        let canEnter = sut.canEnterQueue(person: 50,
                                         queue: [40],
                                         maxPeople: 2,
                                         maxWeight: 100)
        XCTAssertTrue(canEnter)
    }
    
    func testCanEnterQueue_max_people_reached() {
        let canEnter = sut.canEnterQueue(person: 50,
                                         queue: [40, 50],
                                         maxPeople: 2,
                                         maxWeight: 100)
        XCTAssertFalse(canEnter)
    }
    
    func testCanEnterQueue_max_weight_reached() {
        let canEnter = sut.canEnterQueue(person: 50,
                                         queue: [40],
                                         maxPeople: 2,
                                         maxWeight: 40)
        XCTAssertFalse(canEnter)
    }
    
    // MARK: - queueTicks(..)
    
    func testQueueTicks_people_2floor() {
        let queueTicks = sut.queueTicks([40], destinations: [2], floors: 4)
        
        XCTAssertEqual(queueTicks, 4)
    }
    
    func testQueueTicks_people_to_3floor() {
        let queueTicks = sut.queueTicks([60], destinations: [3], floors: 4)
        
        XCTAssertEqual(queueTicks, 6)
    }
    
    func testQueueTicks_people_to_2floor_and_3floor() {
        let queueTicks = sut.queueTicks([40, 50], destinations: [2, 3], floors: 4)
        
        XCTAssertEqual(queueTicks, 7)
    }
    
    func testQueueTicks_people_to_3floor_and_4floor() {
        let queueTicks = sut.queueTicks([40, 50], destinations: [3, 4], floors: 4)
        
        XCTAssertEqual(queueTicks, 9)
    }
    
    func testQueueTicks_people_and_destinations_different_count() {
        let queueTicks = sut.queueTicks([40, 50], destinations: [3], floors: 4)
        
        XCTAssertEqual(queueTicks, 0)
    }
    
}
