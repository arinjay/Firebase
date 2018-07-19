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


class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YourCellDelegate {

    
    // MARK: - Linking labels to main storyboard
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    
     // MARK: - setting Up TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    // Edit button to go to Edit Screen
    @IBAction func editBack(_ sender: UIButton) {
            performSegue(withIdentifier: "editBack", sender: self)
    }
    
    // Logout Function from Firebase
    @IBAction func logoutButton(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logoutSuccess", sender: self)
            //presentingViewController?.dismiss(animated: true, completion: nil)
        }catch{
            print("Error while signing out!")
        }
    }
    
    // Reference of Firebase database
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Creating local variable to get Data from FirebaseDatabase
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
        
        // Registering Custom Tableview
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cusCell")
        tableView.delegate = self
        tableView.dataSource = self
       
        
    }
    
    
    // TableView Datasource funtions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cusCell", for: indexPath) as! CustomCell
        cell.delegate = self
        tableView.backgroundColor = .clear
        cell.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        cell.placeNameLabel.text = placeArray[indexPath.row]
        cell.distanceLabel.text = distanceArray[indexPath.row]
        
        
        
        return cell
    }
    
    // Custom Height of tableView
    func configureTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 240
    }
    
    func didTapButton(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            print(indexPath)
        }
    }
    
    // Get index of the current cell pressed.
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    var placeArray = ["St Louis", "Texas","Indiana","Iowa"]
    var distanceArray = ["120 km", "80 Km", "65 Km","138 Km"]
    var currentIndex = 0
    var destinationLatituteArray = ["38.643172","40.261761","42.015678","31.596136"]
    var destinationLongituteArray = ["-90.177429","-86.265951","-93.780600","-98.702475"]
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMap", sender: self)
        currentIndex = indexPath.row
    }
    
    
    // GO to next ViewController when clicked on ShowMap Button
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destination = segue.destination as? FourthViewController
            destination?.destiLat = Double(destinationLatituteArray[currentIndex])!
            destination?.destiLon = Double(destinationLongituteArray[currentIndex])!
        }
    }
    
    
    

}
