//
//  ViewController.swift
//  ProfileCardApp
//
//  Created by Coditas on 25/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var devImage: UIImageView!  //outlet for an image
    @IBOutlet weak var devName: UILabel!       //outlets for name and description
    @IBOutlet weak var devDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Making image circular
        devImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        devImage.widthAnchor.constraint(equalToConstant: 100).isActive = true

        devImage.layer.cornerRadius = devImage.frame.width / 2
        devImage.clipsToBounds = true
        devImage.contentMode = .scaleAspectFit
        devImage.image = UIImage(named: "myImage")  // Use the name shown in Assets

        
        // setting the background color
        view.backgroundColor = UIColor.black
        
        devName.text = "TusharJ"
        devDetails.text = "Aspiring iOS Developer in Coditas"
        
        // setting style for name label
        devName.textColor = UIColor.white
        devName.font = UIFont.boldSystemFont(ofSize: 24)
        devName.textAlignment = .center
        
        // setting style for developer profile description
        devDetails.textColor = UIColor.lightGray
        devDetails.font = UIFont.systemFont(ofSize: 16)
        devDetails.textAlignment = .center
        devDetails.numberOfLines = 0
    }
}

