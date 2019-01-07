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
        
        _ = calculateLiftTicks(floors: 10, maxPeople: 4, maxWeight: 100, weightArray: [80, 80, 80], destinationArray: [2, 3, 3])
    }
    
    public func calculateLiftTicks(floors: Int, maxPeople: Int, maxWeight: Int, weightArray: [Int], destinationArray: [Int]) -> Int {
        var ticks = 0
        var trips = getTripsLeft(maxPeople: maxPeople, maxWeight: maxWeight, weightArray: weightArray)
        let maxToGo = destinationArray.max() ?? floors
        
        while trips > 0 {
            print("Loading at floor 1")
            ticks += 1
            
            for floor in 2...maxToGo {
                print("Moving to floor \(floor)")
                ticks += 1
                print("Unloading at floor \(floor)")
                ticks += 1
            }
            
            for floor in (1...maxToGo).reversed() {
                print("Moving to floor \(floor)")
                ticks += 1
                print("Unloading at floor \(floor)")
                ticks += 1
            }
            
            trips -= 1
        }
        print("Completed")
        ticks += 1
        
        print("ticks = \(ticks)")
        return ticks
    }
    

    // Returns how many times the lift needs to go up and back and to get more people
    private func getTripsLeft(maxPeople: Int, maxWeight: Int, weightArray: [Int]) -> Int {
        guard !weightArray.isEmpty else { return 0 }
        
        var trips = 1
        var weightSum = 0
        var pplCount = 0
        var array = [Int]()
        
        for item in weightArray {
            weightSum += item
            pplCount += 1
            
            if (array.count < maxPeople) || (weightSum <= maxWeight) {
                array.append(item)
            } else {
                print("\(trips) \(array)")
                trips += 1
                array = []
                weightSum = 0
                array.append(item)
            }
        }
        print("trips needed = \(trips)")
        return trips
    }

}

