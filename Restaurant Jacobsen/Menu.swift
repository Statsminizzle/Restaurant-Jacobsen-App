//
//  Menu.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 19/07/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase
class Menu {

    class Category: FirebaseDataObject {
        var name: String?
        var uid: String?
    }
    
    class Item: FirebaseDataObject {
        var name: String?
        var number: String?
        var text: String?
        var uid: String?
        var price: String?
    }
    
    class Section: FirebaseDataObject {
        var name: String?
        var uid: String?
    }
    
    var menuCategories: [Int: Category] = [:]
    var menuSections: [String: [Int: Section]] = [:]
    var menuItems: [String: [Int: Item]] = [:]

}
