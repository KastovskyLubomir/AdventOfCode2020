
import Foundation

func getID(input: String) -> Int {
    var low = 0
    var high = 127
    var row = 0
    let array = Array(input)
    for i in 0..<7 {
        if array[i] == "F" {
            high = high - ((high - low) / 2) - 1
            row = high
        } else {
            low = low + ((high - low) / 2) + 1
            row = low
        }
    }
    low = 0
    high = 7
    var col = 0
    for i in 7..<input.count {
        if array[i] == "L" {
            high = high - ((high - low) / 2) - 1
            col = high
        } else {
            low = low + ((high - low) / 2) + 1
            col = low
        }
    }
    return row * 8 + col
}

func findMaxId(input: [String]) -> Int {
    var result = Int.min
    input.forEach {
        let id = getID(input: $0)
        if id > result {
            result = id
        }
    }
    return result
}

func allIds(input: [String]) -> [Int] {
    return input.map { getID(input: $0) }.sorted()
}

func findMissing(input: [Int]) -> Int {
    for i in 1..<input.count {
        if (input[i-1] + 1) != input[i] {
            return input[i] - 1
        }
    }
    return 0
}

let input = readLinesRemoveEmpty(str: inputString)
print("Part 1: \(findMaxId(input: input))")
print("Part 2: \(findMissing(input: allIds(input: input)))")
