//
//  ViewController.swift
//  test4Fir
//
//  Created by Arinjay on 26/06/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit
import FirebaseAuth

import Firebase


class ViewController: UIViewController {

    // MARK: - Linking variable to storyboard
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Creating firebase reference
    var ref : DatabaseReference?
    var databaseHandler : DatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    // MARK: - Login Button function
    @IBAction func loginButton(_ sender: UIButton) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            if segmentControl.selectedSegmentIndex == 0 { // Login
                    Auth.auth().signIn(withEmail: emailTextField.text! , password: passwordTextField.text!, completion: { (user, error) in
                        if user != nil {
                            self.performSegue(withIdentifier: "showData3", sender: self)
                        }else{
                            print("Login error")
                        }
                    })
            }else {
                
                // For new User , create New Entry in FirebaseDatabase
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if user != nil { // SignUP
                        self.performSegue(withIdentifier: "showData1", sender: self)
                    }else{
                        print("signup Error")
                    }
                })
            }
        }
    
    }
}
