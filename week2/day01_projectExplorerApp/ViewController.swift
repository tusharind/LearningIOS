import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var bundleIdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }

    private func configureLabels() {
        let allLabels = [nameLabel, versionLabel, bundleIdLabel]

        for label in allLabels {
            label?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            label?.numberOfLines = 0
            label?.lineBreakMode = .byWordWrapping
            label?.textAlignment = .left
        }

        nameLabel.text = "App Name: Project Explorer"

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version: \(version)"
        } else {
            versionLabel.text = "Version: 1.0"
        }

        bundleIdLabel.text = "Bundle ID: \(Bundle.main.bundleIdentifier ?? "com.yourcompany.ProjectExplorer")"
    }
}
