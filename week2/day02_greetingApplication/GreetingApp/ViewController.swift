//
//  ViewController.swift
//  GreetingApp
//
//  Created by Coditas on 23/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forName: UITextField!
    
    @IBOutlet weak var forLals
    bel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forLabel.text = "" // Empty initially
    }


    @IBAction func clicked(_ sender: Any) {
        
        let name = forName.text ?? ""
                if name.isEmpty {
                    forLabel.text = "Please enter your name"
                    forLabel.textColor = .systemRed
                } else {
                    forLabel.text = "Hey, \(name)!"
                    forLabel.textColor = .label
                }
    }
}

