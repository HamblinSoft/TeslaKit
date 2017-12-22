//
//  TKDriveState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Returns the driving and position state of the vehicle.
public struct TKDriveState {

    ///
    public var shiftState: String?

    // TODO: Complete other properties

    public var speed: String? = nil
    public var longitude: Double = 0
    public var gps_as_of: Int = 0
    public var power: Int = 0
    public var latitude: Double = 0
    public var heading: Int = 0
    public var timestamp: Int = 0

    ///
    public init() {}
}

extension TKDriveState: TKDataResponse {

    public mutating func mapping(map: Map) {
        shiftState <- map["shift_state"]
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

