//
//  FileName : ViewController.swift
//  Project Name : MyCal
//  Project Documentation : This program is a mini calculator.
//
//  Created by Jinho Seo on 6/16/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IB means Interface builder. nil is not set, null, optional.
    @IBOutlet weak var display: UILabel!
 
    // This is a inference type so that you can't declare BOOL type.
    var userIsInTheMiddleOfTyping = false
    
    // touchDigit Button Handler
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
    
    // Initialize Struct and Internal implementation by calling the brain value of CalculatorBrain Class
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue) // call method of CalculatorBrain Class
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

