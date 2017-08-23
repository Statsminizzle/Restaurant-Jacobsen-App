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
    
    
    // MARK: - Menu
    
    func downloadCategories(menu: Menu){
        ref.child("MenuCategories").observe(.value, with: { snapshot in
            for (index, child) in snapshot.children.enumerated() {
                menu.menuCategories[index+1] = (Menu.Category.init(snapshot: child as! DataSnapshot))
                print(menu.menuCategories[index+1]?.name ?? "doh")
            }
            guard let categoriesDelegate = self.delegate as? MasterViewController else {
                print("not MasterViewViewController but: \(self.delegate?.classForCoder)")
                
                return
            }
            
            categoriesDelegate.setCategories(menu: menu)
        })
    }
    
    
    func downloadSections(category: Menu.Category, menu: Menu){
        print("downloadSections \(category.uid)")
        ref.child("MenuSections/" + "\(category.uid!)").observe(.value, with: { snapshot in
            print("category uid: \(category.uid)")
            print("ref url: \(snapshot.ref.url)")
            let numberOfSections = Int(snapshot.childrenCount)
            print("number of sections: \(numberOfSections)" + " \(snapshot.childrenCount)")
            let counter = AtomicInteger()
            for (index, child) in snapshot.children.enumerated() {
                var sections = menu.menuSections[category.name!]
                let section = Menu.Section(snapshot: child as! DataSnapshot)
                
                if sections == nil {
                    sections = [index+1: section ]
                    menu.menuSections[category.name!] = sections
                } else {
                    let merge = sections?.merge(with: [index+1: section])
                    menu.menuSections[category.name!] = merge
                }
                print("Section: \(section.name)")
                self.downloadItemsForSection(section: section, numberOfSections: numberOfSections, menu: menu, counter: counter)
            }
            
            guard let sectionDelegate = self.delegate as? DetailTableViewController else {
                print("not DetailTableViewController but: \(self.delegate?.classForCoder)")
                
                return
            }
            
            sectionDelegate.setSectionDelegate(menu: menu, numberOfSections: numberOfSections)
        })
    }
    
    func downloadItemsForSection(section: Menu.Section, numberOfSections: Int, menu: Menu, counter: AtomicInteger) {
        print("downloading items from section \(section.name)")
        ref.child("MenuItems/" + "\(section.uid!)").observe(.value, with: { snapshot in
            for (index, child) in snapshot.children.enumerated() {
                var items = menu.menuItems[section.name!]
                let item = Menu.Item(snapshot: child as! DataSnapshot)
                let key = index+1
                
                if items == nil {
                    items = [key: item]
                    menu.menuItems[section.name!] = items
                } else {
                    let merge = items?.merge(with: [key: item])
                    menu.menuItems[section.name!] = merge
                }
                print("Item: \(item.name)")
            }
            
            if counter.increment() == numberOfSections {
                guard let sectionDelegate = self.delegate as? DetailTableViewController else {
                    print("not DetailTableViewController but: \(self.delegate?.classForCoder)")
                    
                    return
                }
                
                sectionDelegate.setSectionDelegate(menu: menu, numberOfSections: numberOfSections)
            }
        })
    }
    
}
