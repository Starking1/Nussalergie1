//
//  ViewController.swift
//  Nussalergie
//
//  Created by timi on 03.07.16.
//  Copyright © 2016 Scheissegal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        button.hidden = true
        textLabel.text = "Hallo Timmy"
        textLabel.hidden = false
    }

}

