//
//  ViewController.swift
//  GreetingApp
//
//  Created by Coditas on 24/07/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var displayGreeting: UILabel!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        // Label Colors
        titleLabel.textColor = .white
        displayGreeting.textColor = .white

        // Text Field
        textField.textColor = .white
        textField.backgroundColor = UIColor.darkGray
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )

        // Set default label text
        titleLabel.text = "Welcome!"
        displayGreeting.text = ""
    }

    @IBAction func greetButtonTapped(_: UIButton) {
        let name = textField.text ?? ""
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            displayGreeting.text = "Please enter your name"
        } else {
            displayGreeting.text = "Hello, \(name)!"
        }
    }
}
