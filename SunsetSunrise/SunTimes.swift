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
}

struct Results: Decodable {
    let results: SunTimes
}

