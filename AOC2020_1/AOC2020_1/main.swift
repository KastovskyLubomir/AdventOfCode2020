//
//  main.swift
//  AOC2020_1
//
//  Created by Lubomír Kaštovský on 11/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

import Foundation


let numbers = readLinesRemoveEmpty(str: inputString).compactMap {
    Int($0)
}

func sumNubersOnIndexes(numbers: [Int], indexes: [Int]) -> Int {
    var result = 0
    print(indexes)
    indexes.forEach {
        result += numbers[$0]
    }
    print(result)
    return result
}

func findSumNumbers(numbers: [Int], sum: Int, sumNumbersCount: Int) -> [Int] {
    var result = [Int]()
    let sortedNumbers = numbers.sorted()
    print(sortedNumbers.count)
    var indexes = Array.init(repeating: 0, count: sumNumbersCount)
    for i in 0..<indexes.count {
        if i != 0 {
            indexes[i] = indexes[i-1] + 1
        }
    }
    //print(indexes)
    while true {
        let resultSum = sumNubersOnIndexes(numbers: sortedNumbers, indexes: indexes)
        if resultSum == sum {
            indexes.forEach {
                result.append(sortedNumbers[$0])
            }
            break
        }
        /*
        if resultSum > sum {
            indexes[indexes.count-1] = sortedNumbers.count
        }
 */
        for i in stride(from: indexes.count-1, to: -1, by: -1) {
            indexes[i] += 1
            if indexes[i] < (sortedNumbers.count - (sumNumbersCount - i - 1)) {
                break
            }
        }

        for i in 0..<indexes.count {
            if indexes[i] >= (sortedNumbers.count - (sumNumbersCount - i - 1)) && i > 0 {
                indexes[i] = indexes[i-1] + 1
            }
        }
    }
    return result
}

let resultNumbers = findSumNumbers(numbers: numbers, sum: 2020, sumNumbersCount: 2)
var result = 0
resultNumbers.forEach {
    if result != 0 {
        result = result * $0
    } else {
        result += $0
    }
}
print(result)


let resultNumbers2 = findSumNumbers(numbers: numbers, sum: 2020, sumNumbersCount: 3)
var result2 = 0
resultNumbers2.forEach {
    if result2 != 0 {
        result2 = result2 * $0
    } else {
        result2 += $0
    }
}
print(result2)

