import UIKit

// MARK: - Success View Controller
class SuccessVC: UIViewController {
    
    // MARK: - Properties
    var feedback: Feedback?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var recommendLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var visitsLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayFeedbackData()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func displayFeedbackData() {
        guard let feedback = feedback else {
            showNoDataMessage()
            return
        }
        
        updateLabelsWithFeedback(feedback)
    }
    
    private func updateLabelsWithFeedback(_ feedback: Feedback) {
        categoryLabel.text = "Your category: \(feedback.category.rawValue)"
        visitsLabel.text = "Number of times visited: \(feedback.visits)"
        genderLabel.text = "Gender: \(feedback.gender.rawValue)"
        ratingLabel.text = "You rated us: \(feedback.rating)"
        recommendLabel.text = "Will you recommend us? \(feedback.recommend ? "Yes" : "No")"
    }
    
    private func showNoDataMessage() {
        // Handle case where no feedback data is available
        overviewLabel.text = "No feedback data available"
    }
    
    // MARK: - IBActions
    @IBAction private func submitAgainTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
