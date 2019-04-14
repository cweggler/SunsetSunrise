//
//  ViewController.swift
//  SunsetSunrise
//
//  Created by Cara on 4/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, SunTimesDelegate {

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
            locationManager!.requestLocation()
            currentLocation = locationManager!.location
            
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
            sunTimesService.sunTimesDelegate = self
            sunTimesService.fetchSunTimes(location: currentLocation)
        }
        else {
            print("Location is nil")
        }
    }
    
    func sunTimesFetched(sunTimes: Results) {
       DispatchQueue.main.async {
            let sunriseText = "\(sunTimes.results.sunrise)"
            self.sunriseLabel.text = sunriseText

            let sunsetText = "\(sunTimes.results.sunset)"
            self.sunsetLabel.text = sunsetText
        }
    }
    
    func sunTimesFetchError(because sunTimesError: SunTimesError) {
        print(sunTimesError) 
    }
    

}

