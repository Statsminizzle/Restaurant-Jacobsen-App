//
//  Reservation.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 15/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import Foundation

struct Reservation {

    var numberOfPersons: String
    var date: String
    var time: String
    
    var contact: Contact?
    
    struct Contact {
        var name: String
        var email: String
        var phone: String
        var comment: String?
        var birthday: Bool
    }
    
    func getReservationDetailText() -> String {
        return numberOfPersons + ", " + date + ", " + time
    }
    
    func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = ["name": self.contact!.name, "email": self.contact!.email, "phone": self.contact!.phone, "comment": self.contact!.comment ?? "", "birthday": self.contact!.birthday, "numberOfPersons": self.numberOfPersons, "date": self.date, "time": self.time]
        return dictionary
    }
}
