//
//  AddDetailsViewController.swift
//  WheresMyCar
//
//  Created by Matthew Joyce on 12/5/16.
//  Copyright © 2016 Matthew Joyce. All rights reserved.
//

import UIKit
import CoreLocation

class AddDetailsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerData = ["Meter", "Parking Deck", "Regular Parking Spot", "Other"]
    var name: String?
    var notes: String?
    var type: String?
    var image: UIImage?
    var location: CLLocation?
    var timeStamp: NSDate?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(AddDetailsViewController.saveMethod))
        navigationItem.rightBarButtonItem = saveButton
        super.viewDidLoad()
        nameTextField.delegate = self
        notesTextField.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddDetailsViewController.tappedMe))
        imageField.addGestureRecognizer(tap)
        imageField.isUserInteractionEnabled = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        CLLocationManager.locationServicesEnabled()
        // Do any additional setup after loading the view.
    }

    func saveMethod() {
        findLocation()
    }
    
    func tappedMe() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        let photo = info[UIImagePickerControllerOriginalImage] as? UIImage
        image = photo!
        imageField.image = resizeImage(image: image!, newWidth: 230)
    }
    
    
    //Loosly based on: Source http://stackoverflow.com/questions/31966885/ios-swift-resize-image-to-200x200pt-px
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: 200))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: 200))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            name = textField.text!
        } else if textField == notesTextField {
            notes = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Location Manager
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    //Called when a location is found
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            //Last will be the most recent location found.
            currentLocation = locations.first
            var loc = [loggedLocation]()
            loc.append(loggedLocation(name: name, photo: image, notes: notes, timeStamp: NSDate(), location: currentLocation))
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(loc, toFile: loggedLocation.ArchiveURL.path)
            if !isSuccessfulSave {
                print("Failed to save meals...")
            }
            //performSegue(withIdentifier: "toTableView", sender: self)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
