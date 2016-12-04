//
//  SecondViewController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/4/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit
import MapKit

class locationViewController: UIViewController {
    
    //Default Location is Boone
    let initialLocation = CLLocation(latitude: 36.216795, longitude: -81.6745517)
    let regionRadius: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    * centerMapOnLocation
    *
    * Helper method for centering map on location passed in.
    */
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }


}

