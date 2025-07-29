import UIKit

class ContactDetailVC: UIViewController {
    var contact: Contact?

    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = contact?.name ?? "Contact Details"
        applyStyles()
        setContactData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactImageView.layer.cornerRadius = contactImageView.frame.width / 2
        contactImageView.clipsToBounds = true
    }

    private func setContactData() {
        nameLabel.text = contact?.name ?? "No Name"
        phoneLabel.text = "📞 \(contact?.phone ?? "")"
        emailLabel.text = "💌 \(contact?.email ?? "")"
        if let imageName = contact?.imageName {
            contactImageView.image = UIImage(named: imageName)
        } else {
            contactImageView.image = UIImage(systemName: "person.circle")
        }
    }

    private func applyStyles() {
        nameLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        nameLabel.textColor = .label

        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneLabel.textColor = .secondaryLabel

        emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailLabel.textColor = .secondaryLabel

        nameLabel.textAlignment = .center
        phoneLabel.textAlignment = .center
        emailLabel.textAlignment = .center
    }
}
