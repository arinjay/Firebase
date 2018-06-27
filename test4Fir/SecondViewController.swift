//
//  SecondViewController.swift
//  test4Fir
//
//  Created by Arinjay on 26/06/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
//ximport SkyFloatingLabelTextField
class SecondViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nametextField: UITextField!
    
    @IBOutlet weak var stateTextField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        // To check if text is entered or not
        if stateTextField.text != "" && nametextField.text != "" {
        
        // Posting the data on firebase database
        let userID = Auth.auth().currentUser?.uid
        let post = [ "Name" : nametextField.text,
                      "State" : stateTextField.text
                    ]
        
        ref.child("user").child(userID!).setValue(post)
        
        //presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    

}
