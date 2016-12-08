//
//  mapOnlyViewController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/7/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapOnlyViewController: UIViewController, CLLocationManagerDelegate {
    
    let initialLocation = CLLocation(latitude: 36.216795, longitude: -81.6745517)
    let regionRadius: CLLocationDistance = 500
    var carLocation = CLLocation()
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    var name = String()
    var type = String()
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCarToMap()
        centerMapOnLocation(location: carLocation)
        locationManager = CLLocationManager()
        map.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
        map.showsUserLocation = true
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
                                                                  regionRadius * 1.0, regionRadius * 1.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    //Puts the car on the map at your current location
    func addCarToMap() {
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = (carLocation.coordinate)
        annotation.title = name
        annotation.subtitle = type
        //annotation.subtitle = "Cats"
        map.addAnnotation(annotation)
    }
    
    func addCurrentLocationToMap() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = (carLocation.coordinate)
        annotation.title = "Your current Location"
        //annotation.subtitle = "Cats"
        map.addAnnotation(annotation)
    }
    
    //Accessor for current location
    func getCurrentLocation() -> CLLocation {
        return currentLocation
    }
    
    //Location manager to obtain a locatin fix, may take several secounds.
    func findLocation() {
        locationManager.requestLocation()
    }
    
    //Print to console in case of error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: " + error.localizedDescription)
    }
    
    //Check authorization status
    func canGetLocation() -> Bool {
        return (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied &&
            CLLocationManager.authorizationStatus() != CLAuthorizationStatus.restricted)
    }
    
    

   

}
