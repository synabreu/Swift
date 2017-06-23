//
//  ViewController.swift
//  MyCal
//
//  Created by Jinho Seo on 6/16/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    // nil is not set, null, optional.
    
    var userIsInTheMiddleOfTyping = false // BOOL 선언하지 않아도 됨, infer(추측 또는 추론 할 수 있음)
    
 
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
          
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        // print("\(digit) was touched")
    }
    
    // computed property
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    // Initialize Struct and Internal implementation
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue) // call method
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
 
}

