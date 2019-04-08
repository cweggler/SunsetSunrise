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
    
    func fetchSunTimes(location: CLLocation) {
        
        let url_str = "https://api.sunrise-sunset.org/json?lat=\(location.coordinate.latitude)&lng=\(location.coordinate.longitude)"
        let url = URL(string: url_str)
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let sunTimesData = data {
                let decoder = JSONDecoder()
                let results = try! decoder.decode(Results.self, from: sunTimesData)
                print(results)
            }
        }
        task.resume()
    }
}
