import UIKit

class SuccessViewController: UIViewController {
    @IBOutlet var overviewLabel: UILabel!

    var feedback: Feedback?

    override func viewDidLoad() {
        super.viewDidLoad()

        styleOverviewLabel()

        if let feedback = feedback {
            overviewLabel.text = """

            Category: \(feedback.category)
            Rating: \(feedback.rating)
            Recommend: \(feedback.recommend ? "Yes" : "No")
            Visits: \(feedback.visits)
            Gender: \(feedback.gender)

            """
        }
    }

    func styleOverviewLabel() {
        overviewLabel.layer.borderWidth = 1
        overviewLabel.layer.borderColor = UIColor.gray.cgColor
        overviewLabel.layer.cornerRadius = 8
        overviewLabel.layer.masksToBounds = true
    }

    @IBAction func submitAgainTapped(_: UIButton) {
        // Go back to the form
        navigationController?.popViewController(animated: true)
    }
}
