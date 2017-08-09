//
//  MenuSplitViewController.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 02/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit

class MenuSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let detailCollectionViewController = secondaryViewController as? DetailCollectionViewController else {
            print("detailCollectionViewController false")
            print(secondaryViewController.classForCoder)
            return false }
        
        if detailCollectionViewController.category == nil {
            print("category nil = true")
            return true
        }
        print("func false")
        return false
    }
    
}
