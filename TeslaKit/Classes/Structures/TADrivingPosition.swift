//
//  TADrivingPosition.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TADrivingPosition {

    ///
    public struct Response {

        ///
        public var shiftState: String?

        // TODO: Complete other properties

        var speed: String?
        var longitude: Double = 0
        var gps_as_of: Int = 0
        var power: Int = 0
        var latitude: Double = 0
        var heading: Int = 0
        var timestamp: Int = 0

        ///
        public init() {}
    }
}

extension TADrivingPosition.Response: TADataRequestResponse {

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
