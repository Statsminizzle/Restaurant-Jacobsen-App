//
//  DAL.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 23/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class DAL: FirebaseDatabaseReference{
    
    weak var delegate: UIViewController?
    
    // MARK: - Reservations
    func saveReservation(reservation: Reservation) {
        ref.child("reservations").childByAutoId().setValue(reservation.toDictionary())
    }
    
    // MARK: - News
    func downloadNews() {
        let queryRef = ref.child("News")
        ref.child("News").observe(.value, with: { snapshot in
            var newsArray: [News] = []
            for (child) in snapshot.children {
                let newsItem = News(snapshot: child as! DataSnapshot)
                newsArray.append(newsItem)
            }
            
            print("news downloaded")
            guard let newsDelegate = self.delegate as? NewsTableViewController else {
                print("not newsTableViewController but: \(self.delegate?.classForCoder)")
                return
            }
            
            newsDelegate.newsDownloaded(news: newsArray)
            
        })
    }
    
    
}
