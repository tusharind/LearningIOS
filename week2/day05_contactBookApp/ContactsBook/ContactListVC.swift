import UIKit

class ContactListVC: UITableViewController {
    
    
    //an array to statistically give data to each cell in the table view
    let contacts = [
        Contact(name: "Tushar Jaiswal", phone: "+91 1234567890", email: "tushar@example.com",imageName: "myImage"),
        Contact(name: "Vishnu Gupta", phone: "+91 9876543210", email: "vishnu@example.com",imageName: "vishnu"),
        Contact(name: "Suhani Verma", phone: "+91 5551234567", email: "suhani@example.com",imageName: "aditi"),
        Contact(name: "Sunakshi Singh", phone: "+91 5551234567", email: "sunaksalathia@example.com",imageName: "aditi"),
        Contact(name: "Sneha Garg", phone: "+91 5551234567", email: "sneha@example.com",imageName: "aditi"),
        Contact(name: "Siddharth Singh", phone: "+91 5551234567", email: "sid@example.com",imageName: "sid"),
        Contact(name: "Tushar Jaiswal", phone: "+91 1234567890", email: "tushar@example.com",imageName: "myImage"),
        Contact(name: "Vishnu Gupta", phone: "+91 9876543210", email: "visnu@example.com",imageName: "vishnu"),
        Contact(name: "Suhani Verma", phone: "+91 5551234567", email: "suhani@example.com",imageName: "aditi"),
        Contact(name: "Sunakshi Singh", phone: "+91 5551234567", email: "sunaksalathia@example.com",imageName: "aditi"),
        Contact(name: "Uzair Ali", phone: "+91 9876543210", email: "uzzu@example.com",imageName: "uzzu"),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylingNavigation()
        
    }
    
    func stylingNavigation() -> Void {
        self.title = "Contacts"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        //  to apply styling to the navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    
    //tells the table how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    // This method creates or reuses a cell using:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    //this method is called when the user taps a row.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "showDetail", sender: self)
        let selectedContact = contacts[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailVC {
            detailVC.contact = selectedContact
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    //to pass the data to the details screen through a segue
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showDetail",
    //           let detailVC = segue.destination as? ContactDetailViewController,
    //           let indexPath = tableView.indexPathForSelectedRow {
    //            detailVC.contact = contacts[indexPath.row]
    //        }
    //    }
}


