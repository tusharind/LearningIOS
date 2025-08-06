import UIKit

// MARK: - Enums for Type-Safety
/// A type-safe enum for the feedback categories.
enum FeedbackCategory: String, CaseIterable {
    case ambience = "Ambience"
    case food = "Food"
    case hospitality = "Hospitality"
    case pricing = "Pricing"
    case theme = "Theme"
}

/// A type-safe enum for the user's gender.
enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

// MARK: - Data Model
struct Feedback {
    let category: FeedbackCategory
    let rating: Int
    let recommend: Bool
    let visits: Int
    let gender: Gender
}

// MARK: - Main View Controller
class FeedbackVC: UIViewController {
    
    // MARK: - Constants
    private let progressUpdateInterval: TimeInterval = 0.2
    private let progressIncrement: Float = 0.1
    
    // MARK: - Properties
    private var selectedCategory: FeedbackCategory = .food
    
    // MARK: - IBOutlets
    @IBOutlet private var categoryPicker: UIPickerView!
    @IBOutlet private var experienceSlider: UISlider!
    @IBOutlet private var visitsStepper: UIStepper!
    @IBOutlet private var genderSegment: UISegmentedControl!
    @IBOutlet private var submitButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var recommendSwitch: UISwitch!
    @IBOutlet private var recommendLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var visitCountLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInitialValues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetFormState()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "Feedback Form"
        
        // Setup picker view
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.selectRow(0, inComponent: 0, animated: false)
        
        // Setup gender segment
        genderSegment.removeAllSegments()
        for (index, gender) in Gender.allCases.enumerated() {
            genderSegment.insertSegment(withTitle: gender.rawValue, at: index, animated: false)
        }
        genderSegment.selectedSegmentIndex = 0
        
        // Setup activity indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        // Setup slider
        experienceSlider.minimumValue = 0
        experienceSlider.maximumValue = 5
        
        // Setup progress view
        progressView.progress = 0
    }
    
    private func setupInitialValues() {
        updateSliderLabel()
        updateSwitchLabel()
        updateStepperLabel()
    }
    
    private func resetFormState() {
        // Reset progress and activity indicator
        progressView.progress = 0
        activityIndicator.stopAnimating()
        
        // Reset form controls to default values
        categoryPicker.selectRow(0, inComponent: 0, animated: false)
        selectedCategory = .allCases[0]
        experienceSlider.value = 3
        visitsStepper.value = 3
        genderSegment.selectedSegmentIndex = 0
        recommendSwitch.setOn(true, animated: false)
        
        // Update labels
        ratingLabel.text = "Rate us: 3"
        visitCountLabel.text = "Visits: 3"
        recommendLabel.text = "Will you recommend: Yes"
        
        // Enable all controls
        enableFormControls(true)
        
        // Reset submit button
        submitButton.setTitle("Submit", for: .normal)
        submitButton.isEnabled = true
    }
    
    // MARK: - UI State Management
    private func enableFormControls(_ enabled: Bool) {
        categoryPicker.isUserInteractionEnabled = enabled
        experienceSlider.isEnabled = enabled
        recommendSwitch.isEnabled = enabled
        visitsStepper.isEnabled = enabled
        genderSegment.isEnabled = enabled
        submitButton.isEnabled = enabled
    }
    
    // MARK: - Label Updates
    private func updateSliderLabel() {
        ratingLabel.text = "Rate us: \(Int(experienceSlider.value))"
    }
    
    private func updateStepperLabel() {
        visitCountLabel.text = "Visits: \(Int(visitsStepper.value))"
    }
    
    private func updateSwitchLabel() {
        let value = recommendSwitch.isOn ? "Yes" : "No"
        recommendLabel.text = "Will you recommend: \(value)"
    }
    
    // MARK: - IBActions
    @IBAction private func sliderChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        print("slider moved to \(value)")
        ratingLabel.text = "Rate us: \(value)"
    }
    
    @IBAction private func switchChanged(_ sender: UISwitch) {
        let value = sender.isOn ? "Yes" : "No"
        recommendLabel.text = "Will you recommend: \(value)"
    }
    
    @IBAction private func stepperChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        visitCountLabel.text = "Visits: \(value)"
    }
    
    @IBAction private func submitTapped(_ sender: UIButton) {
        startSubmissionProcess()
    }
    
    // MARK: - Submission Process
    private func startSubmissionProcess() {
        enableFormControls(false)
        submitButton.setTitle("Submitting...", for: .disabled)
        activityIndicator.startAnimating()
        progressView.progress = 0
        simulateSubmission()
    }
    
    private func simulateSubmission() {
        var progress: Float = 0.0
        
        Timer.scheduledTimer(withTimeInterval: progressUpdateInterval, repeats: true) { timer in
            progress += self.progressIncrement
            self.progressView.setProgress(progress, animated: true)
            
            if progress >= 1.0 {
                timer.invalidate()
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "showSuccessScreen", sender: nil)
            }
        }
    }
            
    // MARK: - Data Creation
    private func createFeedbackObject() -> Feedback {
        let selectedCategory = FeedbackCategory.allCases[categoryPicker.selectedRow(inComponent: 0)]
        let rating = Int(experienceSlider.value)
        let visits = Int(visitsStepper.value)
        let selectedGenderIndex = genderSegment.selectedSegmentIndex
        let gender = Gender.allCases[selectedGenderIndex]
        let recommend = recommendSwitch.isOn
        
        return Feedback(
            category: selectedCategory,
            rating: rating,
            recommend: recommend,
            visits: visits,
            gender: gender
        )
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showSuccessScreen",
              let destinationVC = segue.destination as? SuccessVC else {
            return
        }
        
        destinationVC.feedback = createFeedbackObject()
    }
}

// MARK: - UIPickerView DataSource & Delegate
extension FeedbackVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FeedbackCategory.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FeedbackCategory.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = FeedbackCategory.allCases[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = FeedbackCategory.allCases[row].rawValue
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
}
