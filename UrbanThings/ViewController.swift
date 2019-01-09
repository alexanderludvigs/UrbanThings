//
//  ViewController.swift
//  UrbanThings
//
//  Created by Alexander on 06/01/2019.
//  Copyright © 2019 alexanderludvigs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = calculateLiftTicks(floors: 5, maxPeople: 2, maxWeight: 200, weightArray: [60, 80, 40], destinationArray: [2, 3, 2])
    }
    
    public func calculateLiftTicks(floors: Int, maxPeople: Int, maxWeight: Int, weightArray: [Int], destinationArray: [Int]) -> Int {
        // minor error handling
        guard weightArray.count == destinationArray.count else { return 0 }
        guard maxWeight >= weightArray.min()! else { return 0 }
        guard maxPeople > 0 else { return 0 }
        
        var ticks = 0
        var queue = [Int]()
        var waiting = weightArray
        
        while !waiting.isEmpty {
            if waiting.indices.contains(0) {
                if canEnterQueue(person: waiting[0], queue: queue, maxPeople: maxPeople, maxWeight: maxWeight) {
                    // remove first from copy and add to queue
                    queue.append(waiting.remove(at: 0))
                    if waiting.isEmpty {
                        let subDestinations = Array(destinationArray[0..<queue.count])
                        ticks += queueTicks(queue, destinations: subDestinations, floors: floors)
                        queue = []
                    }
                } else {
                    let subDestinations = Array(destinationArray[0..<queue.count])
                    ticks += queueTicks(queue, destinations: subDestinations, floors: floors)
                    queue = []
                }
            }
        }
        
        // if ticks are more then 0 it means
        // that the lift has moved so we add
        // the final tick which is completed
        if ticks > 0 {
            ticks += 1
        }
        
        debugPrint("total ticks = ", ticks)
        return ticks
    }
    
    public func canEnterQueue(person: Int, queue: [Int], maxPeople: Int, maxWeight: Int) -> Bool {
        var tmp = queue
        tmp.append(person)
        
        if tmp.count <= maxPeople {
            let totalWeight = tmp.reduce(0, +)
            if totalWeight <= maxWeight {
                return true
            }
        }
        return false
    }
    
    public func queueTicks(_ queue: [Int], destinations: [Int], floors: Int) -> Int {
        // minor error handling
        guard queue.count == destinations.count, !queue.isEmpty else { return 0 }
        
        var ticks = 0
        let startLevel = 1
        let topLevel = destinations.max() ?? floors
        
        for floor in (1...floors) {
            if floor == startLevel {
                // loading at 1
                debugPrint("loading at \(floor)")
                ticks += 1
            } else {
                // check if unloading is needed
                if destinations.contains(floor) {
                    // moving to floor
                    debugPrint("moving to \(floor)")
                    ticks += 1
                    // unload
                    debugPrint("unloading at \(floor)")
                    ticks += 1
                } else {
                    // moving to floor
                    debugPrint("moving to \(floor)")
                    ticks += 1
                }
                // top reached
                if floor == topLevel {
                    // floors to move back
                    ticks += (floor-1)
                    
                    var x = floor-1
                    
                    while x > 0 {
                        debugPrint("moving to \(x)")
                        x -= 1
                    }
                    
                    break
                }
            }
        }
        
        return ticks
    }

}
