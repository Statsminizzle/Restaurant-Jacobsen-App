//
//  DetailCollectionViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 25/07/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "MenuItemCell"
private let reuseHeaderIdentifier = "MenuHeader"

extension Dictionary {
    
    func merge(with dictionary: Dictionary) -> Dictionary {
        var copy = self
        dictionary.forEach {
            (copy.updateValue($1, forKey: $0))
        }
        return copy
    }
}

class DetailCollectionViewController: UICollectionViewController, FirebaseDatabaseReference {

    var menu: Menu?
    var counter: AtomicInteger?
    var numberOfSections: Int = 0

    var category: Menu.Category! {
        didSet {
            if oldValue != nil {
                if category.name != oldValue.name {
                    refreshUI()
                    downloadSections()
                }
            } else {
            downloadSections()
            }
        }
    }
    
    func downloadSections(){
        ref.child("MenuSections/" + "\(self.category.uid!)").observe(.value, with: { snapshot in
            print("category uid: \(self.category.uid)")
            print("ref url: \(snapshot.ref.url)")
            self.numberOfSections = Int(snapshot.childrenCount)
            print("number of sections: \(self.numberOfSections)" + " \(snapshot.childrenCount)")
            self.counter = AtomicInteger()
            for (index, child) in snapshot.children.enumerated() {
                var sections = self.menu!.menuSections[self.category.name!]
                let section = Menu.Section(snapshot: child as! DataSnapshot)
                
                if sections == nil {
                    sections = [index+1: section ]
                    self.menu!.menuSections[self.category.name!] = sections
                } else {
                    let merge = sections?.merge(with: [index+1: section])
                    self.menu!.menuSections[self.category.name!] = merge
                }
                print("Section: \(section.name)")
                self.downloadItemsForSection(section: section)
            }
            self.refreshUI()
        })
    }
    
    func downloadItemsForSection(section: Menu.Section) {
        print("downloading items from section \(section.name)")
        ref.child("MenuItems/" + "\(section.uid!)").observe(.value, with: { snapshot in
            for (index, child) in snapshot.children.enumerated() {
                var items = self.menu?.menuItems[section.name!]
                let item = Menu.Item(snapshot: child as! DataSnapshot)
                let key = index+1
                
                if items == nil {
                    items = [key: item]
                    self.menu!.menuItems[section.name!] = items
                } else {
                    let merge = items?.merge(with: [key: item])
                    self.menu!.menuItems[section.name!] = merge
                }
                print("Item: \(item.name)")
            }
            if self.counter?.increment() == self.numberOfSections {
                self.refreshUI()
            }
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
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


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = menu?.menuSections[category.name!]
        let section = sections?[section+1]
        
        if section != nil {
          return (menu?.menuItems[(section!.name)!]?.count) ?? 0
        }
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuItemCell
        
        // Configure the cell
        let sections = self.menu?.menuSections[category.name!]
        let section = sections?[indexPath.section+1]
        
        let items = self.menu?.menuItems[(section?.name)!]
        for (key, value) in (items)! {
            print("items keys index = \(key) with value: \(value.name) and price: \(value.price)")
        }
        print("Item cell sections : \(sections?.count) with section: \(section?.name) with items : \(items?.count)")
        
        let item = items?[indexPath.item+1]
        
        print("Item cell : \(item?.name) on indexpath section \(indexPath.section) and item \(indexPath.item)")
        if item != nil {
        cell.setNumber(number: (item?.number)!)
        cell.setPrice(price: (item?.price)!)
        cell.setText(name: (item?.name)!, description: (item?.text)!)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! MenuHeaderReusableView
            let sections = menu?.menuSections[category.name!]
            let section = sections?[indexPath.section+1]
            
            if section != nil {
            let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
            let underlineAttributedString = NSAttributedString(string: (section?.name)!, attributes: underlineAttribute)
            header.title.attributedText = underlineAttributedString
            }
            return header
                
        default:
            assert(false, "Only expecting SectionHeader element")
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - CategorySelectionDelegate
extension DetailCollectionViewController: CategorySelectionDelegate {
    func categorySelected(newCategory: Menu.Category, menu: Menu) {
        category = newCategory
        self.menu = menu
    }
}

