//
//  FirebaseDataObject.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 05/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDataObject: NSObject {
    
    required init(snapshot: DataSnapshot) {
        super.init()
        
        for child in snapshot.children.allObjects as? [DataSnapshot] ?? [] {
            if responds(to: Selector(child.key)) {
                 setValue(child.value, forKey: child.key)
            }
        }
    }
}

protocol FirebaseDatabaseReference {
    var ref: DatabaseReference { get }
}

extension FirebaseDatabaseReference {
    var ref: DatabaseReference {
        return Database.database().reference()
    }
}
