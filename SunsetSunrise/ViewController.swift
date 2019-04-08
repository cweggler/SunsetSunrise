//
//  ViewController.swift
//  SunsetSunrise
//
//  Created by Cara on 4/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation!
    let sunTimesService = SunTimesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // get the user's location
            currentLocation = locationManager!.location
            locationManager!.requestLocation()
            
        } else {
            let alert = UIAlertController(title: "Can't display location", message: "Please grant permission in settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: {(action: UIAlertAction) -> Void in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!) } ))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error)") // For example location disabled for device
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentLocation != nil {
            sunTimesService.fetchSunTimes(location: currentLocation)
            //TODO Update the labels
//            sunriseLabel.text = SunTimes.
//            sunsetLabel.text = SunTimes.sunset
        }
        else {
            print("Location is nil")
        }
    }
}

