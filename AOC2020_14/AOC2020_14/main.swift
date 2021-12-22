//
//  main.swift
//  AOC2020_5
//
//  Created by Lubomír Kaštovský on 14/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

import Foundation

func numberToBinString(number: Int) -> String {
    let n = String(number, radix: 2)
    return String.init(repeating: "0", count: 36 - n.count) + n
}

func binStringToNumber(number: String) -> Int {
    return Int(number, radix: 2) ?? 0
}

func applyMask(number: String, mask: String) -> String {
    var result = ""
    let num = Array(number)
    //print(num)
    let mas = Array(mask)
    //print(mas)
    for i in 0..<num.count {
        if mas[i] == "X" {
            result.append(num[i])
        } else {
            result.append(mas[i])
        }
    }
    //print(result)
    return result
}

func applyMask2(number: String, mask: String) -> [String] {
    var result = Array<Character>()
    let num = Array(number)
    let mas = Array(mask)
    let xCount = mas.filter({$0 == "X"}).count
    for i in 0..<num.count {
        if mas[i] == "0" {
            result.append(num[i])
        }
        if mas[i] == "X" {
            result.append("X")
        }
        if mas[i] == "1" {
            result.append("1")
        }
    }
    var resultArray = [String]()
    for i in 0..<(2 << (xCount - 1)) {
        let b = String(i, radix: 2)
        let bin = Array(String.init(repeating: "0", count: xCount - b.count) + b)
        var tmp = ""
        var binIndex = 0
        for j in 0..<result.count {
            if result[j] == "X" {
                tmp.append(bin[binIndex])
                binIndex += 1
            } else {
                tmp.append(result[j])
            }
        }
        resultArray.append(tmp)
    }
    return resultArray
}

func execute(program: [String]) -> Int {
    var memory = [Int:Int]()
    var mask = ""
    for line in program {
        let parts = line.components(separatedBy: [" ", "[", "]"])
        let code = parts[0]
        if code == "mask" {
            mask = parts[2]
        }
        if code == "mem" {
            let number = numberToBinString(number: Int(parts[4])!)
            let masked = applyMask(number: number, mask: mask)
            let address = Int(parts[1])!
            memory[address] = binStringToNumber(number: masked)
        }
    }
    //print(memory)
    var sum = 0
    for key in memory.keys {
        sum += memory[key] ?? 0
    }
    return sum
}

func execute2(program: [String]) -> Int {
    var memory = [Int:Int]()
    var mask = ""
    for line in program {
        let parts = line.components(separatedBy: [" ", "[", "]"])
        let code = parts[0]
        if code == "mask" {
            mask = parts[2]
        }
        if code == "mem" {
            //let number = numberToBinString(number: Int(parts[4])!)
            let address =  numberToBinString(number: Int(parts[1])!)
            let maskedAddresses = applyMask2(number: address, mask: mask)
            //print(address)
            //print(mask)
            //print(maskedAddresses)
            //print("-------------------")
            for addr in maskedAddresses {
                let a = binStringToNumber(number: addr)
                memory[a] = Int(parts[4])!
            }
        }
    }
    //print(memory)
    var sum = 0
    for key in memory.keys {
        sum += memory[key] ?? 0
    }
    return sum
}

let program = readLinesRemoveEmpty(str: inputString)


print(String("mem[8] = 11").components(separatedBy: [" ", "[", "]"]))
print(String("mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X").components(separatedBy: [" ", "[", "]"]))

print(execute(program: program))
print(execute2(program: program))
