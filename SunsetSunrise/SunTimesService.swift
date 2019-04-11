//
//  SunTimesService.swift
//  SunsetSunrise
//
//  Created by Cara on 4/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation
import MapKit

class SunTimesService {
    
    var sunTimesDelegate: SunTimesDelegate?
    
    func fetchSunTimes(location: CLLocation) {
        
        let url_str = "https://api.sunrise-sunset.org/json?lat=\(location.coordinate.latitude)&lng=\(location.coordinate.longitude)&date=today"
        
        guard let delegate = sunTimesDelegate else {
            print("Warning - no delegate set")
            return
        }
        let url = URL(string: url_str)
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {(data, response, error) in
            
            if let error = error {
                delegate.sunTimesFetchError(because: SunTimesError(message: error.localizedDescription))
            }
            
            if let sunTimesData = data {
                let decoder = JSONDecoder()
                if let results = try? decoder.decode(SunTimes.self, from: sunTimesData) {
                    delegate.sunTimesFetched(sunTimes: results)
                }
                else{
                delegate.sunTimesFetchError(because: SunTimesError(message: "Unable to decode response from quote server"))
                }
            }
            
        })
        
        task.resume()
    }
}

class SunTimesError: Error {
    let message: String
    
    init(message: String){
        self.message = message
    }
}
