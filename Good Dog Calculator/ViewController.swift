//
//  ViewController.swift
//  Good Dog Calculator
//
//  Created by ESTEBAN, ALEXANDRA (LYHS) on 1/17/20.
//  Copyright © 2020 Ally Esteban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogView: UIImageView!
    @IBOutlet weak var outputText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        outputText.text = "good boy!"
    }
    

}

