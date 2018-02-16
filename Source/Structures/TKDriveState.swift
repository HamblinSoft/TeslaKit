//
//  TKDriveState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response object containing information about the driving and position state of the vehicle
public struct TKDriveState { 

    ///
    public var shiftState: TKShiftState = TKShiftState.park

    ///
    public var speed: Int = 0

    ///
    public var longitude: Double = 0

    ///
    public var gpsAsOf: TimeInterval = 0

    ///
    public var power: Int = 0

    ///
    public var latitude: Double = 0

    ///
    public var headingValue: Double = 0

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var heading: TKHeading {
        switch Double(self.headingValue) {
        case 0..<22.5: return .n
        case 22.5..<67.5: return .ne
        case 67.5..<112.5: return .e
        case 112.5..<157.5: return .se
        case 157.5..<202.5: return .s
        case 202.5..<247.5: return .sw
        case 247.5..<292.5: return .w
        case 292.5..<337.5: return .nw
        case 337.5..<360: return .n
        default: return .n
        }
    }

    ///
    public init() {}
}

extension TKDriveState: TKDataResponse {

    public mutating func mapping(map: Map) {
        speed <- map["speed"]
        shiftState <- (map["shift_state"], EnumTransform())
        headingValue <- map["heading"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        gpsAsOf <- map["gps_as_of"]
    }
}

//{
//    "shift_state" : "P",
//    "speed" : null,
//    "longitude" : -117.896179,
//    "gps_as_of" : 1513809832,
//    "power" : 0,
//    "latitude" : 33.782539,
//    "heading" : 172,
//    "timestamp" : 1513809833025
//}

