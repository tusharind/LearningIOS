import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!        // static title label
    @IBOutlet weak var name: UITextField!            // text field for name
    @IBOutlet weak var age: UITextField!             // text field for age
    @IBOutlet weak var namesLabel: UILabel!            // static label for age
    @IBOutlet weak var agesLabel: UILabel!           // static label for name
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayLabel.text = "We need you details!"
        displayLabel.font = UIFont.boldSystemFont(ofSize: 28)
        displayLabel.textColor = UIColor.systemBlue
        displayLabel.textAlignment = .center
        displayLabel.numberOfLines = 0

        // name label
        agesLabel.text = "Age"
        agesLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        agesLabel.textColor = .label

        // age label
        namesLabel.text = "Name"
        namesLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        namesLabel.textColor = .label

        // name text field
        name.placeholder = "Enter your name"
        name.text = ""
        name.borderStyle = .roundedRect
        name.clearButtonMode = .whileEditing
        name.autocapitalizationType = .words

        // sge text field
        age.placeholder = "Enter your age"
        age.text = ""
        age.borderStyle = .roundedRect
        age.keyboardType = .numberPad
        age.clearButtonMode = .whileEditing
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueid", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueid",
           let nextPage = segue.destination as? SecondViewController {
            nextPage.userName = name.text
            nextPage.userAge = Int(age.text ?? "")
        }
    }
}

