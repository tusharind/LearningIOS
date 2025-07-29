import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var userAgeLabel: UILabel! // age label
    @IBOutlet var userNameLabel: UILabel! // name label

    // Received variables
    var userName: String?
    var userAge: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Name Label Styling
        userNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = UIColor.label
        userNameLabel.numberOfLines = 0

        // Age Label Styling
        userAgeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        userAgeLabel.textAlignment = .center
        userAgeLabel.textColor = UIColor.secondaryLabel
        userAgeLabel.numberOfLines = 0

        // Set texts safely
        if let name = userName?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty {
            userNameLabel.text = "Username: \(name)"
        } else {
            userNameLabel.text = "Could not find this user!!"
        }

        if let age = userAge {
            userAgeLabel.text = "Age: \(age)"
        } else {
            userAgeLabel.text = "Age not found"
        }
    }
}
