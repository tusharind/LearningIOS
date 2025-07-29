
import UIKit

class ViewController: UIViewController {
    @IBOutlet var devImage: UIImageView!
    @IBOutlet var devName: UILabel!
    @IBOutlet var devDetails: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDevImage()
        setupDevName()
        setupDevDetails()
    }

    private func setupView() {
        view.backgroundColor = .black
    }

    private func setupDevImage() {
        devImage.contentMode = .scaleAspectFit
        devImage.image = UIImage(named: "myImage")

        // Setting circular shape
        devImage.layer.cornerRadius = 50 // Assuming fixed size of 100x100
        devImage.clipsToBounds = true
    }

    private func setupDevName() {
        devName.text = "TusharJ"
        devName.textColor = .white
        devName.font = UIFont.boldSystemFont(ofSize: 24)
        devName.textAlignment = .center
    }

    private func setupDevDetails() {
        devDetails.text = "Aspiring iOS Developer in Coditas"
        devDetails.textColor = .lightGray
        devDetails.font = UIFont.systemFont(ofSize: 16)
        devDetails.textAlignment = .center
        devDetails.numberOfLines = 0
    }
}
