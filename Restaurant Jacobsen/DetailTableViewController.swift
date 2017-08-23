//
//  DetailTableViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 19/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "MenuTableViewCell"
private let reuseHeaderIdentifier = "MenuHeaderTableViewCell"

protocol getSectionDelegate {
    func setSectionDelegate(menu: Menu, numberOfSections: Int)
}


class DetailTableViewController: UITableViewController, FirebaseDatabaseReference {

    var menu: Menu?
    var counter: AtomicInteger?
    var numberOfSections: Int = 0
    var dal: DAL?
    
    var category: Menu.Category! {
        didSet {
            
            if menu == nil {
                menu = Menu()
                dal = DAL()
                dal!.delegate = self
            }
            
            if oldValue != nil {
                if category.name != oldValue.name {
                    refreshUI()
                    dal?.downloadSections(category: category, menu: menu!)
                }
            } else {
                    dal?.downloadSections(category: category, menu: menu!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("category nil \(category == nil)")
        if category != nil {
            if menu!.menuSections[category.name!] != nil {
                print("SECTIONS = \(menu!.menuSections[category.name!]!.count)")
            }
            print("numberOfSections in view = \((menu!.menuSections[category.name!]?.count)) and nos = \(self.numberOfSections)")
            return (menu!.menuSections[category.name!]?.count) ?? 0
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = menu?.menuSections[category.name!]
        let section = sections?[section+1]
        
        if section != nil {
            let counter = (menu?.menuItems[(section!.name)!]?.count) ?? 0
            print("SECTION \(section) has \(counter) ITEMS")
            if let count = (menu?.menuItems[(section!.name)!]?.count) {
                return count+1 // to make space for header
            }
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Section Header
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseHeaderIdentifier) as! MenuHeaderTableViewCell
        
            // Configure the cell
            let sections = self.menu?.menuSections[category.name!]
            if let section = sections?[indexPath.section+1] {
                cell.titleLabel.text = section.name
            }
            
            return cell
        } else { //Section items
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! MenuTableViewCell
            
            // Configure the cell
            let sections = self.menu?.menuSections[category.name!]
            let section = sections?[indexPath.section+1]
            
            let items = self.menu?.menuItems[(section?.name)!]
            for (key, value) in (items)! {
                print("items keys index = \(key) with value: \(value.name) and price: \(value.price)")
            }
            print("Item cell sections : \(sections?.count) with section: \(section?.name) with items : \(items?.count)")
            
            let item = items?[indexPath.item]
            
            print("Item cell : \(item?.name) on indexpath section \(indexPath.section) and item \(indexPath.item)")
            if item != nil {
                cell.setNumber(number: (item?.number)!)
                cell.setPrice(price: (item?.price)!)
                cell.setText(name: (item?.name)!, description: (item?.text)!)
            }
            
            return cell
        }
    }
    
    /*
    func indexPathToItem(indexPath: IndexPath) -> Menu.Item {
        
    }*/
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*
        let sections = menu?.menuSections[category.name!]
        let section = sections?[section+1]
        
        if section != nil {
            return section!.name
        }
        */
        return nil
    }

    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            //self.tableView.invalidateIntrinsicContentSize()
            //self.tableView?.layoutIfNeeded()
            self.tableView?.layoutSubviews()
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailTableViewController: CategorySelectionDelegate {
    func categorySelected(newCategory: Menu.Category, menu: Menu) {
        category = newCategory
        self.menu = menu
    }
}

extension DetailTableViewController: getSectionDelegate {
    func setSectionDelegate(menu: Menu, numberOfSections: Int) {
        print("setSelectionDelegate called")
        self.menu = menu
        self.numberOfSections = numberOfSections
        self.refreshUI()
    }
}
