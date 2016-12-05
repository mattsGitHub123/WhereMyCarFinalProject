//
//  SecondViewController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/4/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class locationViewController: UIViewController, CLLocationManagerDelegate {
    
    //Default Location is Boone
    let initialLocation = CLLocation(latitude: 36.216795, longitude: -81.6745517)
    let regionRadius: CLLocationDistance = 1000
    
    //Handles management of the location services
    //var locationManager: locationManagerController!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    /*
    * findLocationButton
    *
    * Once clicked a request should be made for the current location
    * and should be displayed on the MKMapView
    */
    @IBAction func findLocationButton(_ sender: Any) {
        //Check that location services access is allowed and on
        if canGetLocation() {
            findLocation()
        } else {
            //Show error alert message
            let alert = UIAlertController(title: "Alert", message: "Location Request could not be made", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Puts the car on the map at your current location
    func addCarToMap() {
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = (currentLocation?.coordinate)!
        annotation.title = "Car"
        annotation.subtitle = "Cats"
        
        mapView.addAnnotation(annotation)
    }
    
    /*
    func shareLocationInstance() -> locationManagerController {
        if locationManager == nil {
            locationManager = locationManagerController()
        }
        return locationManager
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up locationManager so location can be found.
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied ||
            CLLocationManager.authorizationStatus() != CLAuthorizationStatus.restricted {
            locationManager = CLLocationManager()
            
            locationManager.delegate = self
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            CLLocationManager.locationServicesEnabled()
        }

        //shareLocationInstance()
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
            regionRadius * 1.0, regionRadius * 1.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    // Location Manager
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    //Called when a location is found
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            //Last will be the most recent location found.
            currentLocation = locations.first
            centerMapOnLocation(location: currentLocation!)
            addCarToMap()
        }
    }
    
    //Accessor for current location
    func getCurrentLocation() -> CLLocation {
        while (currentLocation == nil) {
            //wait
        }
        return currentLocation!
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

