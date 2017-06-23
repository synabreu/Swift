//
//  CalculatorBrain.swift
//  MyCal
//
//  Created by Jinho Seo on 6/17/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import Foundation


// global func -- 양음수 표시 positive, negative
// func changeSign(operand: Double) -> Double {
//     return -operand
// }

// 똑같은 binaryOperation 케이스를 사용하기 위해 4가지의 function을 closures 를 통해 구현
// func multiply(op1: Double, op2: Double) -> Double {
//    return op1 * op2
// }


struct CalculatorBrain {
    
    private var accumulator: Double?
    
    // Type 이 다른 sqrt, cos 를 위해 처리 (파이와 e는 double, sqrt는 func 타입 , 
    // enum - it's basically a data structure that has discrete value.
    
    // associated value is double. remember optional has this thing where when it's in the set stage it has this associated value that's associated with the set state, but is not associated with the not set state? Okay, optional is an enum. It's an enum with two cases. The not set case, which is called none and the set case, which is called sum. And in the sum case, it has a little associated value with it. And we can do the exact same thing, okay? In our enum,

    
    private enum Operation {
        case constant(Double) // associated value is something not specific to optionals. It's for all enums in Swift.
        case unaryOperation((Double) -> Double) // func type
        case binaryOperation((Double, Double) -> Double) // binary type
        case equals
    }
    
    
    // constant, unaryOperation, BinaryOperation (2 times 3 equals)
    // if the binary case is using closures - is a function embedded right in line of your code
    private var operations: Dictionary<String, Operation> = [
        "ㅠ" : Operation.constant(Double.pi), // Double.pi,
        "e"  : Operation.constant(M_E), // M_E,
        "√"  : Operation.unaryOperation(sqrt), // sqrt,
        "cos" : Operation.unaryOperation(cos), // cos
        "±" : Operation.unaryOperation({ -$0 }), // Porting from changeSign to paramenter of closures.
        
        // *** 1. porting funct to closures
        // "×" : Operation.binaryOperation({ (op1: Double, op2: Double) -> Double in
        //     return op1 * op2
        // }),
        
        // *** 2. use Swift's inference of type to make this a lot nicer. cause binaryOperation is the same type of parameter
        // "×" : Operation.binaryOperation({ (op1, op2) in return op1 * op2 }),
        
        // *** 3. reducing it, cause it's alredy known to the type of parameters. $0 and $1 are any number of argument, no extraneous type.
        "×" : Operation.binaryOperation({ $0 * $1 }),
        
        // *** 4. The second purpose of clourses is to allow you to do, is to pass off to methods some piece of code to execute if something fails, or when something completes. Or do this and animate it, while you're doing it. for example, You're gonna see API like that - Operation.binaryOperation(). So, being able to pass these methods around, you're gonna see. Really makes for great, great API. So, you're just seeing the simplest possible use of it here. We just using as the associated value, but imagine it as function, parameters and things like that.   
        
        
        "÷" : Operation.binaryOperation({ $0 / $1 }),
        "+" : Operation.binaryOperation({ $0 + $1 }),
        "−" : Operation.binaryOperation({ $0 - $1 }),
        "=" : Operation.equals
    
    ]
    
    mutating func performOperation(_ symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            // case .constant(Double) :
            case .constant(let value) : // get associated value out - associatedConstantValue
                accumulator = value
            case .unaryOperation(let function) :
                if accumulator != nil { // protect against this crashing your app, accumulator is not set, not optional. it can be equal to nil or something else, and it has an associated value.
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                // pbo = PendingBinaryOperation(function: <#T##(Double, Double) -> Double#>, firstOperand: <#T##Double#>) 1. free initializae
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!) // 2. ! is unwrapped.
                    accumulator = nil // if the weird half state five times, my accumulator is three equals.
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!) // pBO?가 optional 이므로 !를 통해 unwrapped. if ? is not set is, this line is ignored.
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation? // only the person five time so that it's optional, this is not set.
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        // external - with, internal - secondOperand, Documentation
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,  secondOperand)
        }
        
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
