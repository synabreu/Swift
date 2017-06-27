//
//  FileName : ViewController.swift
//  Project Name : HelloWorld
//  Project Documentation : This program displays 'Hello World!'
//
//  Created by Jinho Seo on 5/01/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var msgLabel: UILabel!
    
    var myColor: UIColor = UIColor.white
    var myBGColor: UIColor = UIColor.red
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Configure Label properties
        msgLabel.text = "Hello, World!"
        msgLabel.font = UIFont(name: msgLabel.font.fontName, size: 24)
        msgLabel.textColor = myColor
        msgLabel.backgroundColor = myBGColor
        msgLabel.textAlignment = NSTextAlignment.center
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

