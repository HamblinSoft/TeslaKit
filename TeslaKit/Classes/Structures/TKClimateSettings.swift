//
//  TKClimateSettings.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKClimateSettings {

    ///
    public struct Response {

        ///
        public var seatHeaterLeft: Int = 0

        ///
        public var fanStatus: Int = 0

        // TODO: Complete other properties
        
        var isFrontDefrosterOn: Bool = false
        var is_rear_defroster_on: Bool = false
        var is_climate_on: Bool = false
        var seat_heater_rear_left: Int = 0
        var min_avail_temp: Int = 0
        var inside_temp: String?
        var driver_temp_setting: Double = 0
        var passenger_temp_setting: Double = 0
        var outside_temp: String?
        var seat_heater_rear_center: Int = 0
        var timestamp: Int = 0
        var right_temp_direction: String?
        var left_temp_direction: String?
        var seat_heater_rear_right: Int = 0
        var seat_heater_rear_right_back: Int = 0
        var seat_heater_right: Int = 0
        var seat_heater_rear_left_back: Int = 0
        var smart_preconditioning: Bool = false
        var max_avail_temp: Int = 0
        var is_auto_conditioning_on: String? = nil

        ///
        public init() {}
    }
}

extension TKClimateSettings.Response: TKDataRequestResponse {

    public mutating func mapping(map: Map) {
        seatHeaterLeft <- map["response.seat_heater_left"]
        fanStatus <- map["response.fan_status"]
        isFrontDefrosterOn <- map["response.is_front_defroster_on"]
    }
}

//{
//    "response" : {
//        "seat_heater_left" : 0,
//        "fan_status" : 0,
//        "is_front_defroster_on" : false,
//        "is_rear_defroster_on" : false,
//        "is_climate_on" : false,
//        "seat_heater_rear_left" : 0,
//        "min_avail_temp" : 15,
//        "inside_temp" : null,
//        "driver_temp_setting" : 21.699999999999999,
//        "passenger_temp_setting" : 21.699999999999999,
//        "outside_temp" : null,
//        "seat_heater_rear_center" : 0,
//        "timestamp" : 1511681566429,
//        "right_temp_direction" : null,
//        "left_temp_direction" : null,
//        "seat_heater_rear_right" : 0,
//        "seat_heater_rear_right_back" : 0,
//        "seat_heater_right" : 0,
//        "seat_heater_rear_left_back" : 0,
//        "smart_preconditioning" : false,
//        "max_avail_temp" : 28,
//        "is_auto_conditioning_on" : null
//    }
//}


