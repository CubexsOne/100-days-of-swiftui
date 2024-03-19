//
//  RollsResult.swift
//  RollDice
//
//  Created by Pascal Sauer on 19.03.24.
//

import Foundation
import SwiftData

@Model
class RollsResult {
    var diceAmount: Int = 0
    var sides: Int = 0
    var rolls: [Int] = []
    var result: Int = 0
    
    var formattedRolls: String {
        var formattedOutput = ""
        rolls.forEach { value in
            if formattedOutput.isEmpty {
                formattedOutput = "\(value)"
            } else {
                formattedOutput += " + \(value)"
            }
        }
        return formattedOutput
    }
    
    init(diceAmount: Int, sides: Int, rolls: [Int], result: Int) {
        self.diceAmount = diceAmount
        self.sides = sides
        self.rolls = rolls
        self.result = result
    }
}
