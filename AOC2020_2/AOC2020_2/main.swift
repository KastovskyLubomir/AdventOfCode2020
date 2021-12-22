//
//  main.swift
//  AOC2020_2
//
//  Created by Lubomír Kaštovský on 11/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

import Foundation

let inputArray = readLinesRemoveEmpty(str: inputString)

func passwordValid(policyWithPwd: String) -> Bool {

    let parts = policyWithPwd.split(separator: " ")
    let counts = parts[0].split(separator: "-")
    let min = Int(counts[0])!
    let max = Int(counts[1])!
    let letter = parts[1].first!
    let password = parts[2]

    //print("\(min) \(max) \(letter) \(password)")

    let charArray = Array(password)
    let count = charArray.filter({ $0 == letter }).count

    return count >= min && count <= max
}

func passwordValid2(policyWithPwd: String) -> Bool {

    let parts = policyWithPwd.split(separator: " ")
    let counts = parts[0].split(separator: "-")
    let min = Int(counts[0])! - 1
    let max = Int(counts[1])! - 1
    let letter = parts[1].first!
    let password = parts[2]

    //print("\(min) \(max) \(letter) \(password)")

    let charArray = Array(password)
    //let count = charArray.filter({ $0 == letter }).count

    return (charArray[min] == letter && charArray[max] != letter) ||
        (charArray[min] != letter && charArray[max] == letter)
}

let validPwdCount = inputArray.filter({ passwordValid(policyWithPwd: $0)}).count
print(validPwdCount)
let validPwdCount2 = inputArray.filter({ passwordValid2(policyWithPwd: $0)}).count
print(validPwdCount2)

