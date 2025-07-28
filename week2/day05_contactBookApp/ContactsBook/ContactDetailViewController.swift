//
//  ContactDetailViewController.swift
//  ContactsBook
//
//  Created by Coditas on 27/07/25.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            title = contact?.name
            nameLabel.text = contact?.name
            phoneLabel.text = "📞 \(contact?.phone ?? "")"
            emailLabel.text = "💌 \(contact?.email ?? "")"
        applyStyles()
        
        if let imageName = contact?.imageName {
            contactImageView.image = UIImage(named: imageName)
            contactImageView.layer.cornerRadius = contactImageView.frame.width / 2
        }

  }
    
    private func applyStyles() {
            // styling the name label
            nameLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
            nameLabel.textColor = .label
            
            // styling the phone and email label
            phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            phoneLabel.textColor = .secondaryLabel
            
            emailLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            emailLabel.textColor = .secondaryLabel
            
            // aligning the label in the center
            nameLabel.textAlignment = .center
            phoneLabel.textAlignment = .center
            emailLabel.textAlignment = .center
        }

}
