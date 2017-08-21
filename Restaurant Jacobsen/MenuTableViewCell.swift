//
//  MenuTableViewCell.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 19/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    func setPrice(price: String) {
        self.priceLabel.text = "\(price) kr."
        
    }
    
    func setNumber(number: String) {
        self.numberLabel.text = number + "."
    }
    
    func setText(name: String, description: String) {
        self.descriptionTextView.text = "\(name) \n \(description)"
        //self.descriptionLabel.text = "\(name) \n \(description)"
    }

}
