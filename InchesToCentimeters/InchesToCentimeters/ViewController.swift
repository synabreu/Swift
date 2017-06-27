//
//  FileName : ViewController.swift
//  Project Name : InchesToCentimeters
//  Project Documentation : This program converts inches to centimeters.
//
//  Created by Jinho Seo on 5/07/17.
//  Copyright © 2016 Jinho Seo. All rights reserved.
//


import UIKit
import Foundation


class ViewController: UIViewController {

    // Declare Labels
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Declare Input a number as TextField
    @IBOutlet weak var doubleText: UITextField!
    
    // private constants
    let CENTIMETERS_PER_INCH : Double = 2.54
    
    var inches : Double?
    
    var prompt : Double?
    var result : Double?
    
    // Initialize a view and then configure several label properites
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Label properties
        displayLabel.text = "This program converts inches to centimeters. "
        inputLabel.text = "Enter value in inches: "
        resultLabel.text = ""
    }

    // Button Event Handler to Inches To Centimeters by checking null value
    @IBAction func btnResult(_ sender: Any) {
        
        if let prompt = doubleText.text {
            if Double(prompt) != nil {
                let result2 = Double(prompt)! * CENTIMETERS_PER_INCH
                resultLabel.text = String(describing: prompt) + " inchies = " + String(describing: result2) + " cm"
               
            }
        }
    }
    
}

