//
//  main.swift
//  AOC2020_4
//
//  Created by Lubomír Kaštovský on 12/12/2020.
//  Copyright © 2020 Lubomír Kaštovský. All rights reserved.
//

import Foundation

struct Passport {
    var byr: String?
    var iyr: String?
    var eyr: String?
    var hgt: String?
    var hcl: String?
    var ecl: String?
    var pid: String?
    var cid: String?

    func isValid() -> Bool {
        return byr != nil && iyr != nil && eyr != nil && hgt != nil &&
            hcl != nil && ecl != nil && pid != nil
    }

    func heightCm(height: String) -> Int? {
        if height.contains("cm"), let h = Int(height.dropLast(2)) {
            return h
        }
        return nil
    }

    func heightIn(height: String) -> Int? {
        if height.contains("in"), let h = Int(height.dropLast(2)) {
            return h
        }
        return nil
    }

    func colorValid(color: String) -> Bool {
        var col = color
        guard color.count == 7 && color.first == "#" else { return false }
        col.removeFirst()
        return UInt(col, radix: 16) != nil
    }

    func eyeColorValid(color: String) -> Bool {
        switch color {
        case "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
            return true
        default:
            return false
        }
    }

    func isValidStrict() -> Bool {
        if isValid() {
            guard let b = byr, let birth = Int(b), birth >= 1920, birth <= 2002 else { return false }
            guard let i = iyr, let issue = Int(i), issue >= 2010, issue <= 2020 else { return false }
            guard let e = eyr, let expir = Int(e), expir >= 2020, expir <= 2030 else { return false }
            if let hg = hgt {
                let cm = heightCm(height: hg)
                let inch = heightIn(height: hg)
                if cm == nil && inch == nil { return false }
                if let c = cm, !(c >= 150 && c <= 193) { return false }
                if let i = inch, !(i >= 59 && i <= 76) { return false }
            } else { return false }
            guard let c = hcl, colorValid(color: c) else { return false }
            guard let ey = ecl, eyeColorValid(color: ey) else { return false }
            guard let p = pid, p.count == 9, CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: p))
            else { return false }
            return true
        }
        return false
    }
}

func loadPassports(input: String) -> [Passport] {

    var result = [Passport]()
    let lines = input.components(separatedBy: "\n")
    var passport = Passport()
    for i in lines.indices {
        if !lines[i].isEmpty {
            let parts = lines[i].components(separatedBy: " ")
            for part in parts {
                let keyVal = part.components(separatedBy: ":")
                switch keyVal[0] {
                case "byr":
                    passport.byr = keyVal[1]
                case "iyr":
                    passport.iyr = keyVal[1]
                case "eyr":
                    passport.eyr = keyVal[1]
                case "hgt":
                    passport.hgt = keyVal[1]
                case "hcl":
                    passport.hcl = keyVal[1]
                case "ecl":
                    passport.ecl = keyVal[1]
                case "pid":
                    passport.pid = keyVal[1]
                case "cid":
                    passport.cid = keyVal[1]
                default: break
                }
            }
        } else {
            result.append(passport)
            passport = Passport()
        }
    }

    return result
}

let passports = loadPassports(input: inputString)
print(passports)

print(passports.filter({$0.isValid()}).count)

/*
let x = "abwcd"
print(UInt(x, radix: 16))
 */

print(passports.filter({$0.isValidStrict()}).count)
