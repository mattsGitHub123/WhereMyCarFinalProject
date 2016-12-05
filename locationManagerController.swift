//
//  locationManagerController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/4/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import Foundation
import CoreLocation

class locationManagerController : NSObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied ||
            CLLocationManager.authorizationStatus() != CLAuthorizationStatus.restricted {
            locationManager = CLLocationManager()
            
            locationManager.delegate = self
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }

            CLLocationManager.locationServicesEnabled()
        }
    }
    
    //Called when a location is found
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            //Last will be the most recent location found.
            currentLocation = locations.first
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
