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
    /*var menuCategories: [Int: Category] = [1: Category(name: "Smørrebrød", uid: "1qqwej"), 2: Category(name: "Forretter", uid: "42kadkadj")]
 */   
   /* var menuSections: [String: [Int: Section] ] = ["Smørrebrød": [1: Section(name: "Platter", uid: "23kko"), 2: Section(name: "Håndmadder", uid: "43opo")],
                                                   "Forretter": [1: Section(name: "Forretter", uid: "42kadkadj")] ]
 */
/*
 var menuItems: [String: [Int: Item] ] = ["Platter": [1: Item(name: "Husets Platte", number: "A1", price: 115, text: "lang tekst", uid: "undefined"), 2: Item(name: "Frokostplatte", number: "A2", price: 129, text: "lang tekst", uid: "undefined")],
                                             "Håndmadder": [1: Item(name: "3 stk. håndmad", number: "A4", price: 75, text: "lang tekst", uid: "undefined")],
                                             "Forretter": [1: Item(name: "Rejecocktail", number: "2", price: 62, text: "med kaviar, brød & smør", uid: "undefined"), 2: Item(name: "Hjemmegravad laks", number: "3", price: 59, text: "med brød & sennepsdressing ", uid: "undefined")]]
 */
}
