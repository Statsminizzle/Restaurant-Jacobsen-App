//
//  MasterViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 18/07/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol CategorySelectionDelegate: class {
    func categorySelected(newCategory: Menu.Category, menu: Menu)
}

protocol getCategoriesDelegate: class {
    func setCategories(menu: Menu)
}

class MasterViewController: UITableViewController, FirebaseDatabaseReference {
    
    weak var delegate: CategorySelectionDelegate?
    var menu: Menu?
    var dal: DAL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        if menu == nil {
            menu = Menu()
            dal = DAL()
            dal!.delegate = self
            dal!.downloadCategories(menu: menu!)
        }
    }
    
    
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu?.menuCategories.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let categoryText = menu?.menuCategories[indexPath.row+1]?.name
        cell.textLabel?.text = categoryText

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = menu?.menuCategories[indexPath.row+1]
        self.delegate?.categorySelected(newCategory: selectedCategory!, menu: menu!)
        
        if let detailTableViewController = self.delegate as? DetailTableViewController {
            
            splitViewController?.showDetailViewController(detailTableViewController, sender: nil)
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MasterViewController: getCategoriesDelegate {
    func setCategories(menu: Menu) {
        self.menu = menu
        self.refreshUI()
    }
}
