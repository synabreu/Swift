//
//  FileName : main.swift
//  Project Name : MyCommand
//  Project Documentation : This program adds two integers on the console program.
//
//  Created by Jinho Seo on 5/26/16.
//  Copyright © 2016 Jinho Seo. All rights reserved.
//

import Foundation


var strIntroduction = "This program adds two integers."
print(strIntroduction)

print("Enter FirstNumber: ")
let prompt1 =  readLine()

print("Enter SecondNumber: ")
let prompt2 =  readLine()

if let response1 = prompt1,
    let response2 = prompt2,
    let firstNumber = Int(response1),
    let secondNumber = Int(response2)
{
    
    print("The sum of \(firstNumber) and \(secondNumber) is \(firstNumber + secondNumber)")
}


