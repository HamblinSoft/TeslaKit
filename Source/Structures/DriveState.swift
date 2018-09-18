//
//  DriveState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response object containing information about the driving and position state of the vehicle
public struct DriveState { 

    ///
    public var shiftState: ShiftState = ShiftState.park

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
    public var nativeLocationSupported: Int = 0

    ///
    public var nativeType: String? = nil

    ///
    public var nativeLongitude: Double? = nil

    ///
    public var nativeLatitude: Double? = nil

    ///
    public var heading: Heading {
        switch Double(self.headingValue) {
        case 0..<22.5: return .north
        case 22.5..<67.5: return .northEast
        case 67.5..<112.5: return .east
        case 112.5..<157.5: return .southEast
        case 157.5..<202.5: return .south
        case 202.5..<247.5: return .southWest
        case 247.5..<292.5: return .west
        case 292.5..<337.5: return .northWest
        case 337.5..<360: return .north
        default: return .north
        }
    }

    ///
    public init() {}
}

extension DriveState: DataResponse {

    public mutating func mapping(map: Map) {
        gpsAsOf <- map["gps_as_of"]
        headingValue <- map["heading"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        power <- map["power"]
        shiftState <- (map["shift_state"], EnumTransform())
        speed <- map["speed"]
        timestamp <- map["timestamp"]
        nativeLocationSupported <- map["native_location_supported"]
        nativeType <- map["native_type"]
        nativeLongitude <- map["native_longitude"]
        nativeLatitude <- map["native_latitude"]
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

