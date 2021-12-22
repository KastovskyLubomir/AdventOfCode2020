//
//  main.swift
//  AOC2020_3
//
//  Created by Lubomír Kaštovský on 12/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

import Foundation

let lines = readLinesRemoveEmpty(str: inputString).compactMap {
    Array($0)
}


func countTrees(lines: [[Character]]) -> Int {

    var result = 0
    var x = 0
    var y = 0

    while y < lines.count {
        x += 3
        if x >= lines[y].count {
            x = x - lines[y].count
        }
        y += 1
        if y < lines.count {
            if lines[y][x] == "#" {
                result += 1
            }
        }
    }

    return result
}

func countTrees2(lines: [[Character]], xshift: Int, yshift: Int) -> Int {

    var result = 0
    var x = 0
    var y = 0

    while y < lines.count {
        x += xshift
        if x >= lines[y].count {
            x = x - lines[y].count
        }
        y += yshift
        if y < lines.count {
            if lines[y][x] == "#" {
                result += 1
            }
        }
    }

    return result
}

print(countTrees(lines: lines))

/*
 Right 1, down 1.
 Right 3, down 1. (This is the slope you already checked.)
 Right 5, down 1.
 Right 7, down 1.
 Right 1, down 2.
 */

var result = countTrees2(lines: lines, xshift: 1, yshift: 1)
result = result * countTrees2(lines: lines, xshift: 3, yshift: 1)
result = result * countTrees2(lines: lines, xshift: 5, yshift: 1)
result = result * countTrees2(lines: lines, xshift: 7, yshift: 1)
result = result * countTrees2(lines: lines, xshift: 1, yshift: 2)
print(result)
