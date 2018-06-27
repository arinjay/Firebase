//
//  ThirdViewController.swift
//  test4Fir
//
//  Created by Arinjay on 26/06/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase


class ThirdViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBAction func editBack(_ sender: UIButton) {
            performSegue(withIdentifier: "editBack", sender: self)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logoutSuccess", sender: self)
            //presentingViewController?.dismiss(animated: true, completion: nil)
        }catch{
            print("Error while signing out!")
        }
    }
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userId = Auth.auth().currentUser?.uid
        let emailId = Auth.auth().currentUser?.email
        ref = Database.database().reference()
        ref.child("user").child(userId!).observeSingleEvent(of: .value) { (snapshot) in
            let value =  snapshot.value as? NSDictionary
            let name = value?["Name"] as? String ?? ""
            let state = value?["State"] as? String ?? ""
            
            self.nameLabel.text = name
            self.emailLabel.text = emailId
            self.stateLabel.text = state
        }
        
    }

    

}
