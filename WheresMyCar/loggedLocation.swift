//
//  loggedLocation.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/5/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import Foundation
import UIKit

class loggedLocation {
    var name: String
    var photo: UIImage?
    var notes: String
    var timeStamp: NSDate? //If a meter
    
    init(name: String, photo: UIImage?, notes: String, timeStamp: NSDate?) {
        self.name = name
        self.photo = photo
        self.notes = notes
        self.timeStamp = timeStamp
    }
}
