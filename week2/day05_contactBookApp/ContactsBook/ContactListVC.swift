import UIKit

class ContactListVC: UITableViewController {
    let contacts = [
        Contact(name: "Tushar Jaiswal", phone: "+91 1234567890", email: "tushar@example.com", imageName: "myImage"),
        Contact(name: "Vishnu Gupta", phone: "+91 9876543210", email: "vishnu@example.com", imageName: "vishnu"),
        Contact(name: "Suhani Verma", phone: "+91 5551234567", email: "suhani@example.com", imageName: "aditi"),
        Contact(name: "Sunakshi Singh", phone: "+91 5551234567", email: "sunaksalathia@example.com", imageName: "aditi"),
        Contact(name: "Sneha Garg", phone: "+91 5551234567", email: "sneha@example.com", imageName: "aditi"),
        Contact(name: "Siddharth Singh", phone: "+91 5551234567", email: "sid@example.com", imageName: "sid"),
        Contact(name: "Tushar Jaiswal", phone: "+91 1234567890", email: "tushar@example.com", imageName: "myImage"),
        Contact(name: "Vishnu Gupta", phone: "+91 9876543210", email: "visnu@example.com", imageName: "vishnu"),
        Contact(name: "Suhani Verma", phone: "+91 5551234567", email: "suhani@example.com", imageName: "aditi"),
        Contact(name: "Sunakshi Singh", phone: "+91 5551234567", email: "sunaksalathia@example.com", imageName: "aditi"),
        Contact(name: "Uzair Ali", phone: "+91 9876543210", email: "uzzu@example.com", imageName: "uzzu"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        applyNavigationBarStyle()
    }

    func applyNavigationBarStyle() {
        title = "Contacts"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]

        cell.textLabel?.text = contact.name ?? "No Name"

        return cell
    }

    // MARK: Passing data using manual instantiation instead of segue

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = contacts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailVC") as? ContactDetailVC {
            detailVC.contact = selectedContact
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
