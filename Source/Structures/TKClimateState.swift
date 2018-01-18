//
//  TKClimateState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response object containing information about the current temperature and climate control state of a vehicle
public struct TKClimateState {

    ///
    public var seatHeaterLeft: Int = 0

    ///
    public var fanStatus: Int = 0

    // TODO: Complete other properties

    public var isFrontDefrosterOn: Bool = false
    public var is_rear_defroster_on: Bool = false
    public var is_climate_on: Bool = false
    public var seat_heater_rear_left: Int = 0
    public var min_avail_temp: Double = 0
    public var inside_temp: String? = nil
    public var driver_temp_setting: Double = 0
    public var passenger_temp_setting: Double = 0
    public var outside_temp: String? = nil
    public var seat_heater_rear_center: Int = 0
    public var timestamp: Int = 0
    public var right_temp_direction: String? = nil
    public var left_temp_direction: String? = nil
    public var seat_heater_rear_right: Int = 0
    public var seat_heater_rear_right_back: Int = 0
    public var seat_heater_right: Int = 0
    public var seat_heater_rear_left_back: Int = 0
    public var smart_preconditioning: Bool = false
    public var max_avail_temp: Double = 0
    public var is_auto_conditioning_on: String? = nil

    ///
    public init() {}
}

extension TKClimateState: TKDataResponse {

    public mutating func mapping(map: Map) {
        seatHeaterLeft <- map["seat_heater_left"]
        fanStatus <- map["fan_status"]
        isFrontDefrosterOn <- map["is_front_defroster_on"]
        driver_temp_setting <- map["driver_temp_setting"]
        passenger_temp_setting <- map["passenger_temp_setting"]
        is_climate_on <- map["is_climate_on"]
        min_avail_temp <- map["min_avail_temp"]
        max_avail_temp <- map["max_avail_temp"]
    }
}

//{
//    "seat_heater_left" : 1,
//    "fan_status" : 0,
//    "is_front_defroster_on" : false,
//    "is_rear_defroster_on" : false,
//    "is_climate_on" : false,
//    "seat_heater_rear_left" : 0,
//    "min_avail_temp" : 15,
//    "inside_temp" : null,
//    "driver_temp_setting" : 22.199999999999999,
//    "passenger_temp_setting" : 22.199999999999999,
//    "outside_temp" : null,
//    "seat_heater_rear_center" : 0,
//    "timestamp" : 1513809833025,
//    "right_temp_direction" : null,
//    "left_temp_direction" : null,
//    "seat_heater_rear_right" : 0,
//    "seat_heater_rear_right_back" : 0,
//    "seat_heater_right" : 0,
//    "seat_heater_rear_left_back" : 0,
//    "smart_preconditioning" : false,
//    "max_avail_temp" : 28,
//    "is_auto_conditioning_on" : null
//}

