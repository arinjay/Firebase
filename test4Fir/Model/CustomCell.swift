//
//  CustomCell.swift
//  test4Fir
//
//  Created by Arinjay on 27/06/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit

protocol YourCellDelegate: class {
    func didTapButton(_ sender: UIButton)
}


class CustomCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    
     weak var delegate: YourCellDelegate?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Bye")
        delegate?.didTapButton(sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.customView.layer.cornerRadius = 15
        self.customView.layer.borderWidth = 2
        self.customView.layer.borderColor =  UIColor(red:0/255, green:0/255, blue:0/255, alpha: 1).cgColor
        
        self.customView.layer.shadowColor =  UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        self.customView.layer.shadowRadius = 12
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
