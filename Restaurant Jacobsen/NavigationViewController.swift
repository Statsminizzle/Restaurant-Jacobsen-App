//
//  NavigationViewController.swift
//  Restaurant Jacobsen
//
//  Created by Anwar Al-shekir on 22/08/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import MapKit

class NavigationViewController: UIViewController {

    @IBAction func FindWayBtn(_ sender: Any) {
        let lattitude:CLLocationDegrees  = 129.22
        let longitude:CLLocationDegrees = 80.00
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(lattitude,longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let option = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan:regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Resturant Jacobsen"
        mapItem.openInMaps(launchOptions: option)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
