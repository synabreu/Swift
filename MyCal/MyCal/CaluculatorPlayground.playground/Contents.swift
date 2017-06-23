//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// 양음수 표시 positive, negative
func changeSign(operand: Double) -> Double {
    return -operand
}

let i = 27
var f: (Double) -> Double
f = changeSign
let x = f(81)

