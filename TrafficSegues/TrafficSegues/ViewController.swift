//
//  FileName    : ViewController.swift
//  ProjectName : TrafficSegues
//  Overview    : This program display two windows for only testing segues.
//
//  Created by Jinho Seo on 7/10/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var segueSwitch: UISwitch!
    // @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When users click on the Yellow Button, perform the "Yellow" segue.
    @IBAction func yellowButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Yellow", sender: nil)
        }
    }
    
    // WHen users click on the Green Button, perform "Green" segue.
    @IBAction func greenButtonTapped(_ sender: Any) {
        if segueSwitch.isOn {
            performSegue(withIdentifier: "Green", sender: nil)
        }
    }

    
    
    

/*
    // when the unwinde segue makes ...
    // unwind segue -- While a segue transitions to another scene, an unwind segue transitions from the current scene to return to a previously displayed scene.
    @IBAction func unwindToRed(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = textField.text
    }
  */
    
}

