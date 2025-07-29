import UIKit

class FirstViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var name: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var namesLabel: UILabel!
    @IBOutlet var agesLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplayLabel()
        configureStaticLabels()
        configureTextFields()
    }

    // MARK: - UI Configuration

    private func configureDisplayLabel() {
        displayLabel.text = "We need your details!"
        displayLabel.font = .boldSystemFont(ofSize: 28)
        displayLabel.textColor = .systemBlue
        displayLabel.textAlignment = .center
        displayLabel.numberOfLines = 0
    }

    private func configureStaticLabels() {
        namesLabel.text = "Name"
        namesLabel.font = .systemFont(ofSize: 18, weight: .medium)
        namesLabel.textColor = .label

        agesLabel.text = "Age"
        agesLabel.font = .systemFont(ofSize: 18, weight: .medium)
        agesLabel.textColor = .label
    }

    private func configureTextFields() {
        name.placeholder = "Enter your name"
        name.text = ""
        name.borderStyle = .roundedRect
        name.clearButtonMode = .whileEditing
        name.autocapitalizationType = .words

        age.placeholder = "Enter your age"
        age.text = ""
        age.borderStyle = .roundedRect
        age.keyboardType = .numberPad
        age.clearButtonMode = .whileEditing
    }

    // MARK: - Actions

    @IBAction func nextButtonTapped(_: UIButton) {
        performSegue(withIdentifier: "segueid", sender: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "segueid",
           let nextPage = segue.destination as? SecondViewController
        {
            nextPage.userName = name.text
            nextPage.userAge = Int(age.text ?? "")
        }
    }
}
