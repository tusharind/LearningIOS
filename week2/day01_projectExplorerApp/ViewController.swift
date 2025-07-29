import UIKit

class ViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var versionLabel: UILabel!
    @IBOutlet var bundleIdLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        styleLabels()
    }

    private func configureLabels() {
        let allLabels = [nameLabel, versionLabel, bundleIdLabel]

        func styleLabels(_ labels: [UILabel?]) {
            for label in labels {
                label?.font = .systemFont(ofSize: 18, weight: .regular)
                label?.numberOfLines = 0
                label?.lineBreakMode = .byWordWrapping
                label?.textAlignment = .left
            }
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
