//
//  SunTimes.swift
//  SunsetSunrise
//
//  Created by Cara on 4/7/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation

struct SunTimes: Decodable {
    let sunrise: String
    let sunset: String
    
    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

struct Results: Decodable {
    let results: SunTimes
}

extension SunTimes {
    
    static let utcDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss a" // Same format as in the API response
        df.timeZone = TimeZone(abbreviation: "UTC")
        return df
    }()
    
    static let localDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.calendar = NSCalendar.current
        df.timeZone = TimeZone.current // Device's time zone
        df.timeStyle = .medium
        return df
    }()
    
    init(from decoder: Decoder) {
        
        // turn strings to local dates
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let sunriseUTCString = try! container.decode(String.self, forKey: CodingKeys.sunrise)
        let sunsetUTCString = try! container.decode(String.self, forKey: CodingKeys.sunset)
        
        // convert to timeStamp in UTC
        let sunriseUTCDate = SunTimes.utcDateFormatter.date(from: sunriseUTCString)
        let sunsetUTCDate = SunTimes.utcDateFormatter.date(from: sunsetUTCString)
        
        // convert UTC Timestamp to local time for device
        sunrise = SunTimes.localDateFormatter.string(from: sunriseUTCDate!)
        sunset = SunTimes.localDateFormatter.string(from: sunsetUTCDate!)
    }
}

