//
//  loggedLocation.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/5/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class loggedLocation: NSObject, NSCoding {
    var name: String?
    var photo: UIImage?
    var notes: String?
    var timeStamp: NSDate? //If a meter
    var location: CLLocation?
    let initialLocation = CLLocation(latitude: 36.216795, longitude: -81.6745517)
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locations")
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let notesKey = "notes"
        static let timeStampKey = "time"
        static let locationKey = "location"
    }
    
    init(name: String?, photo: UIImage?, notes: String?, timeStamp: NSDate?, location: CLLocation?) {
        if name == nil {
            self.name = "Not Provided"
        } else {
            self.name = name
        }
        
        if notes == nil {
            self.name = "Not Provided"
        } else {
            self.notes = notes
        }
        
        if photo == nil {
            self.photo = #imageLiteral(resourceName: "defaultPhoto")
        } else {
            self.photo = photo
        }
        
        if timeStamp == nil {
            self.timeStamp = NSDate()
        } else {
            self.timeStamp = timeStamp
        }
        
        if location == nil {
            self.location = initialLocation
        } else {
            self.location = location
        }
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
        aCoder.encode(timeStamp, forKey: PropertyKey.timeStampKey)
        aCoder.encode(location, forKey: PropertyKey.locationKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notesKey) as? String
        let timeStamp = aDecoder.decodeObject(forKey: PropertyKey.timeStampKey) as? NSDate
        let location = aDecoder.decodeObject(forKey: PropertyKey.locationKey) as? CLLocation
        
        self.init(name: name, photo: photo, notes: notes, timeStamp: timeStamp, location: location)
    }
}
