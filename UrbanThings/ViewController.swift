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
        
    }
    
    // MARK: - Task 2
    
    public func calculateLiftTicks(floors: Int, maxPeople: Int, maxWeight: Int, weightArray: [Int], destinationArray: [Int], numberOfLifts: Int) -> Int {
        // minor error handling
        guard weightArray.count == destinationArray.count else { return 0 }
        guard numberOfLifts > 0 else { return 0 }
        guard maxWeight >= weightArray.min()! else { return 0 }
        guard maxPeople > 0 else { return 0 }
        
        var ticks = 0
        var waiting = weightArray
        var dest = destinationArray
        var lifts = [[Int]]()
        var subDestinations = [[Int]]()
        for _ in (1...numberOfLifts) {
            lifts.append([])
            subDestinations.append([])
        }

        while !waiting.isEmpty {
            
            if waiting.indices.contains(0) {
                
                if let lift = canEnter(person: waiting[0], lifts: lifts, maxPeople: maxPeople, maxWeight: maxWeight) {
                    lifts[lift].append(waiting.remove(at: 0))
                    subDestinations[lift].append(dest.remove(at: 0))
                    
                    if waiting.isEmpty {
                        ticks += queueTicks(lifts, destinations: subDestinations, floors: floors)
                        
                        lifts[lift] = []
                        subDestinations[lift] = []
                    }
                } else {
                    ticks += queueTicks(lifts, destinations: subDestinations, floors: floors)
                    
                    lifts = []
                    subDestinations = []
                    for _ in (1...numberOfLifts) {
                        lifts.append([])
                        subDestinations.append([])
                    }
                    
                }
                
            }
            
        }
        
        // if ticks are more then 0 it means
        // that the lift has moved so we add
        // the final tick which is completed
        if ticks > 0 {
            ticks += 1
        }
        
        debugPrint("total ticks = \(ticks)")
        return ticks
    }
    
    // MARK: - Task 3
    
    public func calculateLiftTicks(floors: Int, maxPeople: Int, maxWeight: Int, weightArray: [Int], destinationArray: [Int], numberOfLifts: Int, expressLifts: Int) -> Int {

        // error handling
        guard weightArray.count == destinationArray.count else { return 0 }
        guard numberOfLifts > 0 else { return 0 }
        guard maxWeight >= weightArray.min()! else { return 0 }
        guard maxPeople > 0 else { return 0 }
        
        var ticks = 0
        var waiting = weightArray
        var dest = destinationArray
        var lifts = [[Int]]()
        var normalDestinations = [[Int]]()
        var exLifts = [[Int]]()
        var exDestinations = [[Int]]()
        
        for _ in (1...numberOfLifts) {
            lifts.append([])
            normalDestinations.append([])
        }
        
        for _ in (1...expressLifts) {
            exLifts.append([])
            exDestinations.append([])
        }
        
        while !waiting.isEmpty {
            
            if waiting.indices.contains(0) {
                
                if let (canExpress, liftNumber) =
                    canEnterExpress(person: waiting[0],
                                    destination: dest[0],
                                    expressLifts: exLifts,
                                    lifts: lifts,
                                    maxPeople: maxPeople,
                                    maxWeight: maxWeight) {
                    
                    if canExpress {
                        
                        exLifts[liftNumber].append(waiting.remove(at: 0))
                        exDestinations[liftNumber].append(dest.remove(at: 0))
                        
                        if waiting.isEmpty {
                            
                            ticks += expressQueueTicks(exLifts, destinations: exDestinations, floors: floors)
                            
                            exLifts[liftNumber] = []
                            exDestinations[liftNumber] = []
                            
                        } else {
                            continue
                        }
                    } else {
                        
                        lifts[liftNumber].append(waiting.remove(at: 0))
                        normalDestinations[liftNumber].append(dest.remove(at: 0))
                        
                        if waiting.isEmpty {
                            
                            ticks += queueTicks(lifts, destinations: normalDestinations, floors: floors)
                            
                            exLifts[liftNumber] = []
                            exDestinations[liftNumber] = []
                            
                        } else {
                            continue
                        }
                    }
                    
                } else {
                    
                    ticks += expressQueueTicks(exLifts, destinations: exDestinations, floors: floors)
                    ticks += queueTicks(lifts, destinations: normalDestinations, floors: floors)

                    exLifts = []
                    exDestinations = []
                    for _ in (1...expressLifts) {
                        exLifts.append([])
                        exDestinations.append([])
                    }
                    
                    lifts = []
                    normalDestinations = []
                    for _ in (1...numberOfLifts) {
                        lifts.append([])
                        normalDestinations.append([])
                    }
                }
                
            }
            
        }
        
        
        // if ticks are more then 0 it means
        // that the lift has moved so we add
        // the final tick which is completed
        if ticks > 0 {
            ticks += 1
        }
        
        debugPrint("total ticks = \(ticks)")
        return ticks
    }
    
    // MARK: - Helpers
    
    /// Returns tuple containing (true, expressLiftNumber) if the person
    /// can enter express lift with the lift number else (false, normalLiftNumber).
    /// But if person can't enter lift because of max weight or persons reached
    /// this function returns nil
    public func canEnterExpress(person: Int, destination: Int, expressLifts: [[Int]], lifts: [[Int]], maxPeople: Int, maxWeight: Int) -> (Bool, Int)?  {
        // even
        if destination % 2 == 0 {
            for (i, exLift) in expressLifts.enumerated() {
                var tmp = exLift
                tmp.append(person)
                
                if tmp.count <= maxPeople {
                    let totalWeight = tmp.reduce(0, +)
                    if totalWeight <= maxWeight {
                        return (true, i)
                    }
                }
            }
            return nil
        } else { // odd
            for (i, lift) in lifts.enumerated() {
                var tmp = lift
                tmp.append(person)
                
                if tmp.count <= maxPeople {
                    let totalWeight = tmp.reduce(0, +)
                    if totalWeight <= maxWeight {
                        return (false, i)
                    }
                }
            }
            return nil
        }
    }
    
    public func canEnter(person: Int, lifts: [[Int]], maxPeople: Int, maxWeight: Int) -> Int? {
        for (i, lift) in lifts.enumerated() {
            var tmp = lift
            tmp.append(person)
            
            if tmp.count <= maxPeople {
                let totalWeight = tmp.reduce(0, +)
                if totalWeight <= maxWeight {
                    return i
                }
            }
        }
        return nil
    }
    
    public func expressQueueTicks(_ queues: [[Int]], destinations: [[Int]], floors: Int) -> Int {
        var ticks = 0
        let startLevel = 1
        
        for (i, q) in queues.enumerated() {
            
            guard q.count > 0 else { break }
            
            let topLevel = destinations[i].max()! // top for each queue
            
            for floor in (1...floors) {
                
                if floor == startLevel {
                    // loading at 1
                    debugPrint("express lift \(i+1) - loading at \(floor)")
                    ticks += 1
                } else {
                    // even
                    if floor % 2 == 0 {
                        // check if unloading is needed
                        if destinations[i].contains(floor) {
                            // moving to floor
                            debugPrint("express lift \(i+1) - moving to \(floor)")
                            ticks += 1
                            // unload
                            debugPrint("express lift \(i+1) - unloading at \(floor)")
                            ticks += 1
                        } else {
                            // moving to floor
                            debugPrint("express lift \(i+1) - moving to \(floor)")
                            ticks += 1
                        }
                        // top reached
                        if floor == topLevel {
                            // floors to move back
                            
                            var x = floor-1
                            
                            while x > 0 {
                                
                                if x % 2 == 0 {
                                    ticks += 1
                                    debugPrint("express lift \(i+1) - moving to \(x)")
                                }
                                
                                if x == 1 {
                                    debugPrint("express lift \(i+1) - moving to \(x)")

                                    ticks += 1
                                }
                                
                                x -= 1
                            }
                            
                            break
                        }
                    } else {
                        //odd
                        continue
                    }
                    
                }
            }
            
        }
        
        return ticks
    }
    
    public func queueTicks(_ queues: [[Int]], destinations: [[Int]], floors: Int) -> Int {
        var ticks = 0
        let startLevel = 1
        
        for (i, q) in queues.enumerated() {
            
            guard q.count > 0 else { break }
            
            let topLevel = destinations[i].max()!
            
            for floor in (1...floors) {
                if floor == startLevel {
                    // loading at 1
                    debugPrint("lift \(i+1) - loading at \(floor)")
                    ticks += 1
                } else {
                    // check if unloading is needed
                    if destinations[i].contains(floor) {
                        // moving to floor
                        debugPrint("lift \(i+1) - moving to \(floor)")
                        ticks += 1
                        // unload
                        debugPrint("lift \(i+1) - unloading at \(floor)")
                        ticks += 1
                    } else {
                        // moving to floor
                        debugPrint("lift \(i+1) - moving to \(floor)")
                        ticks += 1
                    }
                    // top reached
                    if floor == topLevel {
                        // floors to move back
                        ticks += (floor-1)
                        
                        var x = floor-1
                        
                        while x > 0 {
                            debugPrint("lift \(i+1) - moving to \(x)")
                            x -= 1
                        }
                        
                        break
                    }
                }
            }
            
        }
        
        return ticks
    }

}
