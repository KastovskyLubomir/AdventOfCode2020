//
//  main.swift
//  AOC2020_13
//
//  Created by Lubomír Kaštovský on 14/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

/*
 1001612
 19,x,x,x,x,x,x,x,x,41,x,x,x,37,x,x,x,x,x,821,x,x,x,x,x,x,x,x,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,463,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,23
 */

import Foundation

let departure = 1001612
let busses = [19,41,37,821,13,17,29,463,23]

func findBus(departure: Int, busses: [Int]) -> (bus: Int, waitingTime: Int) {
    var shortestWait = Int.max
    var bestBus = 0
    var result = (0, 0)
    for bus in busses {
        let wait = (((departure / bus) + 1) * bus) - departure
        if wait < shortestWait {
            shortestWait = wait
            bestBus = bus
        }
    }
    return (bestBus, shortestWait)
}

let bus = findBus(departure: departure, busses: busses)
print(bus.0 * bus.1)
