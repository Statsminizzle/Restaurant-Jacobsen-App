//
//  MenuItemCell.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 02/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var text: UILabel!
    
    func setPrice(price: String) {
        self.price.text = "\(price) kr."
    }
    
    func setNumber(number: String) {
        self.number.text = number + "."
    }
    
    func setText(name: String, description: String) {
        self.text.text = "\(name) \n \(description)"
    }
}
