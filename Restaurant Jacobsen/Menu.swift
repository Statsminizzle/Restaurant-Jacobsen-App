//
//  Menu.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 19/07/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class Menu {

    struct Categories {
        var name: String
        var uid: String
    }
    
    struct Item {
        var name: String
        var number: String
        var price: Int
        var text: String
        var uid: String
    }
    
    struct Section {
        var name: String
        var uid: String //Might be unnecessary
    }
    
    var menuCategories: [Int: Categories] = [1: Categories(name: "Smørrebrød", uid: "1qqwej"), 2: Categories(name: "Menuer", uid: "42kadkadj")]
    
    var menuSections: [String: [Int: Section] ] = ["Smørrebrød": [1: Section(name: "Platter", uid: "23kko")]]
    var MenuItems: [String: [Int: Item] ] = ["Platter": [1: Item(name: "Husets Platte", number: "A1", price: 129, text: "lang tekst", uid: "undefined")]]
    
}
