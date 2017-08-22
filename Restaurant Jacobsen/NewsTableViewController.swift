//
//  NewsTableViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 21/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "NewsTableViewCell"

class NewsTableViewController: UITableViewController, FirebaseDatabaseReference {
    
    var news: [News] = []
    
    func downloadNews() {
        let queryRef = ref.child("News")
        ref.child("News").observe(.value, with: { snapshot in
            var newsArray: [News] = []
            for (child) in snapshot.children {
                let newsItem = News(snapshot: child as! DataSnapshot)
                newsArray.append(newsItem)
            }
            self.news = newsArray
            self.refreshUI()
        })
    }
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
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
        
        downloadNews()
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
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsTableViewCell

        let newsItem = news[indexPath.item]
        cell.titleLabel.text = newsItem.title
        cell.contentLabel.text = newsItem.text
        // TODO: ISOFORMAT DATE
        cell.dateLabel.text = newsItem.date
        
        return cell
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
