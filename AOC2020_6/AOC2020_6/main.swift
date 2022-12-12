//
//  main.swift
//  AOC2020_6
//
//  Created by Kaštovský Lubomír on 12.12.2022.
//  Copyright © 2022 Kaštovský Lubomír. All rights reserved.
//

import Foundation

let input = inputString.components(separatedBy: "\n")

func sumYesAnswers(input: [String]) -> Int {
    var sum = 0
    var chars = Set<Character>()
    input.forEach { line in
        if !line.isEmpty {
            let parts = Array(line)
            parts.forEach { chars.insert($0) }
        } else {
            sum += chars.count
            chars.removeAll()
        }
    }
    return sum
}

func sumYesAnswers2(input: [String]) -> Int {
    var sum = 0
    var chars = Set<Character>()
    var firstLine = true
    input.forEach { line in
        if !line.isEmpty {
            if firstLine {
                let parts = Array(line)
                parts.forEach { chars.insert($0) }
            } else {
                var newChars = Set<Character>()
                let parts = Array(line)
                chars.forEach {
                    if parts.contains($0) {
                        newChars.insert($0)
                    }
                }
                chars = newChars
            }
            firstLine = false
        } else {
            sum += chars.count
            chars.removeAll()
            firstLine = true
        }
    }
    return sum
}

print(sumYesAnswers(input: input))
print(sumYesAnswers2(input: input))
