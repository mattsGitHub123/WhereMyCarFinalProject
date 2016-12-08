//
//  LoggedLocationsTableViewController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/5/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit
import CoreLocation

class LoggedLocationsTableViewController: UITableViewController {

    var loggedLocations = [loggedLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = fals
        navigationItem.leftBarButtonItem = editButtonItem
        //loadSampleLocations()
        //saveLoggedLocations()
        if let savedLocations = loadLoggedLocations() {
            for location in savedLocations {
                if !(loggedLocations.contains(location)) {
                    loggedLocations.append(location)
                }
            }
        } else {
            loadSampleLocations()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshLoggedLocations()
    }

    func refreshLoggedLocations() {
        if let savedLocations = loadLoggedLocations() {
            for location in savedLocations {
                if !(loggedLocations.contains(location)) {
                    loggedLocations.append(location)
                }
            }
        }
    }
        
    //Used for demo purposes
    func loadSampleLocations() {
        let dateFormatter = DateFormatter()
        var dateAsString = "01-12-2016 12:00"
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        
        let loc = CLLocation(latitude: 0, longitude: 0)
        let parkingDeck = loggedLocation(name: "RiverStreet", photo: #imageLiteral(resourceName: "parkingDeck"), notes: "3rd Floor, near stairs", timeStamp: dateFormatter.date(from: dateAsString) as NSDate?, location: loc, type: "Parking Deck")
    
        dateAsString = "01-11-2016 14:02"
        let parkingMeter = loggedLocation(name: "Parking Meter", photo: #imageLiteral(resourceName: "parkingMeter"), notes: "In front of store", timeStamp: dateFormatter.date(from: dateAsString) as NSDate?, location: loc, type: "Meter")
        
        let parkingSpot = loggedLocation(name: "On Street", photo: #imageLiteral(resourceName: "regularParking"), notes: "Parallel Parked", timeStamp: dateFormatter.date(from: dateAsString) as NSDate?, location: loc, type: "Parking Spot")
        
        loggedLocations += [parkingDeck, parkingMeter, parkingSpot]
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loggedLocations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LoggedLocationTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LoggedLocationTableViewCell
        // Fetches the appropriate meal for the data source layout.
        let indLocation = loggedLocations[indexPath.row]
        cell.nameLabel.text = indLocation.name
        cell.photoImageView.image = indLocation.photo
        cell.notesLabel.text = indLocation.notes
        cell.typeLabel.text = indLocation.type
        return cell
    }
    
    //Archives for Persistents
    func saveLoggedLocations() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(loggedLocations, toFile: loggedLocation.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save Loations...")
        }
    }
    
    //Loads logged locations
    func loadLoggedLocations() -> [loggedLocation]? {
        //print(loggedLocation.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: loggedLocation.ArchiveURL.path) as? [loggedLocation]
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            loggedLocations.remove(at: indexPath.row)
            //Update archieve list
            saveLoggedLocations()
            tableView.deleteRows(at: [indexPath], with: .fade)
            loggedLocations = loadLoggedLocations()!
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //Called when a row is clicked
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapOnlyVC = storyboard?.instantiateViewController(withIdentifier: "mapOnlyViewController") as! mapOnlyViewController
        mapOnlyVC.carLocation = loggedLocations[indexPath.row].location!
        mapOnlyVC.name = loggedLocations[indexPath.row].name!
        mapOnlyVC.type = loggedLocations[indexPath.row].type!
        navigationController?.pushViewController(mapOnlyVC, animated: true)
    }
    
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
