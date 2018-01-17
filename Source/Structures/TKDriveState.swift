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
    public var shiftState: TKShiftState = TKShiftState.park

    // TODO: Complete other properties

    public var speed: String? = nil
    public var longitude: Double = 0
    public var gps_as_of: Int = 0
    public var power: Int = 0
    public var latitude: Double = 0
    public var heading: Int = 0
    public var timestamp: Int = 0

    public var direction: TKDirection {
        switch Double(heading) {
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
        shiftState <- (map["shift_state"], EnumTransform())
        heading <- map["heading"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
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

