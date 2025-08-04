

import UIKit

struct Feedback {
    let category: String
    let rating: Int
    let recommend: Bool
    let visits: Int
    let gender: String
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let categories = ["Ambience", "Food", "Hospitality", "Pricing", "Theme"]
    var selectedCategory = "Food"

    @IBOutlet var categoryPicker: UIPickerView!

    @IBOutlet var experienceSlider: UISlider!

    @IBOutlet var visitsStepper: UIStepper!

    @IBOutlet var genderSegment: UISegmentedControl!

    @IBOutlet var submitButton: UIButton!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet var progressView: UIProgressView!

    @IBOutlet var recommendSwitch: UISwitch!

    @IBAction func sliderChanged(_ sender: UISlider) {
        let value = Int(sender.value)
        print("slider moved to \(value)")
        ratingLabel.text = "Rating: \(value)"
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        let value = sender.isOn ? "Yes" : "No"
        recommendLabel.text = "Recommend: \(value)"
    }

    @IBAction func stepperChanged(_ sender: UIStepper) {
        let value = Int(sender.value)
        visitCountLabel.text = "Visits: \(value)"
    }

    @IBAction func submitTapped(_: UIButton) {
        categoryPicker.isUserInteractionEnabled = false
        experienceSlider.isEnabled = false
        recommendSwitch.isEnabled = false
        visitsStepper.isEnabled = false
        genderSegment.isEnabled = false
        submitButton.isEnabled = false
        submitButton.setTitle("Submitting...", for: .disabled)

        // show activity spinner
        activityIndicator.startAnimating()

        // reset progress bar
        progressView.progress = 0

        // simulate the 2-second submission
        simulateSubmission()
    }

    @IBOutlet var recommendLabel: UILabel!

    @IBOutlet var ratingLabel: UILabel!

    @IBOutlet var visitCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Feedback Form"
        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()

        experienceSlider.minimumValue = 0
        experienceSlider.maximumValue = 5

        progressView.progress = 0

        categoryPicker.selectRow(0, inComponent: 0, animated: false)

        updateSliderLabel()
        updateSwitchLabel()
        updateStepperLabel()
    }

    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return categories.count
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        selectedCategory = categories[row]
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return categories[row]
    }

    func updateSliderLabel() {
        ratingLabel.text = "Rating: \(Int(experienceSlider.value))"
    }

    func updateStepperLabel() {
        visitCountLabel.text = "Visits: \(Int(visitsStepper.value))"
    }

    func updateSwitchLabel() {
        let value = recommendSwitch.isOn ? "Yes" : "No"
        recommendLabel.text = "Recommend: \(value)"
    }

    func simulateSubmission() {
        var progress: Float = 0.0

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            progress += 0.1
            self.progressView.setProgress(progress, animated: true)

            if progress >= 1.0 {
                timer.invalidate()
                self.activityIndicator.stopAnimating()
                // self.showSubmissionConfirmation()
                self.performSegue(withIdentifier: "showSuccessScreen", sender: nil)
            }
        }
    }

    func showSubmissionConfirmation() {
        let selectedRow = categoryPicker.selectedRow(inComponent: 0)
        let selectedCategory = categories[selectedRow]
        let rating = Int(experienceSlider.value)
        let visits = Int(visitsStepper.value)
        let gender = genderSegment.selectedSegmentIndex == 0 ? "Male" : "Female"
        let recommendation = recommendSwitch.isOn ? "Yes" : "No"

        let message = """
        Category: \(selectedCategory)
        Rating: \(rating)
        Recommend: \(recommendation)
        Visits: \(visits)
        Gender: \(gender)
        """

        let alert = UIAlertController(title: "Feedback Submitted", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "showSuccessScreen",
           let destinationVC = segue.destination as? SuccessViewController
        {
            let selectedCategory = categories[categoryPicker.selectedRow(inComponent: 0)]
            let rating = Int(experienceSlider.value)
            let visits = Int(visitsStepper.value)
            let gender = genderSegment.selectedSegmentIndex == 0 ? "Male" : "Female"
            let recommend = recommendSwitch.isOn

            let userFeedback = Feedback(category: selectedCategory, rating: rating, recommend: recommend, visits: visits, gender: gender)

            destinationVC.feedback = userFeedback
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reset form state
        progressView.progress = 0
        activityIndicator.stopAnimating()

        categoryPicker.selectRow(0, inComponent: 0, animated: false)
        selectedCategory = categories[0]

        experienceSlider.value = 3
        visitsStepper.value = 3
        genderSegment.selectedSegmentIndex = 0
        recommendSwitch.setOn(true, animated: false)

        ratingLabel.text = "Rating: 3"
        visitCountLabel.text = "Visits: 3"
        recommendLabel.text = "Recommend: Yes"

        categoryPicker.isUserInteractionEnabled = true
        experienceSlider.isEnabled = true
        recommendSwitch.isEnabled = true
        visitsStepper.isEnabled = true
        genderSegment.isEnabled = true

        submitButton.setTitle("Submit", for: .normal)
        submitButton.isEnabled = true
    }
}
