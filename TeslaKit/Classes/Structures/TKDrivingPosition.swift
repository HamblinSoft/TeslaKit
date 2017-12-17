//
//  TKDrivingPosition.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Returns the driving and position state of the vehicle.
public struct TKDrivingPosition {

    ///
    public var shiftState: String?

    // TODO: Complete other properties

    public var speed: String?
    public var longitude: Double = 0
    public var gps_as_of: Int = 0
    public var power: Int = 0
    public var latitude: Double = 0
    public var heading: Int = 0
    public var timestamp: Int = 0

    ///
    public init() {}
}

extension TKDrivingPosition: TKDataRequestResponse {

    public mutating func mapping(map: Map) {
        shiftState <- map["response.shift_state"]
    }
}

//{
//    "response" : {
//        "shift_state" : "P",
//        "speed" : null,
//        "longitude" : -117.797279,
//        "gps_as_of" : 1511681565,
//        "power" : 0,
//        "latitude" : 33.689331000000003,
//        "heading" : 237,
//        "timestamp" : 1511681566582
//    }
//}
