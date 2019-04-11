//
//  SunTimesDelegate.swift
//  SunsetSunrise
//
//  Created by Cara on 4/9/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import Foundation

// Functions that an object that wishes to receive
// SunTimes (or errors from fetching SunTimes) must implement

protocol SunTimesDelegate {
    func sunTimesFetched(sunTimes: SunTimes)
    func sunTimesFetchError(because sunTimesError: SunTimesError)
}
