//
//  TKVehicleState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleState {

    ///
    public struct Response {

        public var exteriorColor: String?

        // TODO: Complete other properties

        var center_display_state: Int = 0
        var autopark_style: String?
        var remote_start: Bool = false
        var odometer: Double = 0
        var rt: Int = 0
        var sun_roof_percent_open: Int = 0
        var vehicle_name: String?
        var remote_start_supported: Bool = false
        var dark_rims: Bool = false
        var locked: Bool = false
        var rear_seat_type: Int = 0
        var rhd: Bool = false
        var autopark_state_v2: String?
        var roof_color: String?
        var rear_seat_heaters: Int = 0
        var valet_mode: Bool = false
        var parsed_calendar_supported: Bool = false
        var api_version: Int = 0
        var homelink_nearby: Bool = false
        var autopark_state: String?
        var last_autopark_error: String?
        var dr: Int = 0
        var has_spoiler: Bool = false
        var calendar_supported: Bool = false
        var sun_roof_state: String?
        var df: Int = 0
        var valet_pin_needed: Bool = false
        var pr: Int = 0
        var spoiler_type: String?
        var car_type: String?
        var perf_config: String?
        var car_version: String?
        var seat_type: Int = 0
        var third_row_seats: String?
        var ft: Int = 0
        var notifications_supported: Bool = false
        var pf: Int = 0
        var wheel_type: String?
        var sun_roof_installed: Int = 0
        var timestamp: Int = 0

        ///
        public init() {}
    }
}

extension TKVehicleState.Response: TKDataRequestResponse {

    public mutating func mapping(map: Map) {
        exteriorColor <- map["response.exterior_color"]
    }
}

//{
//    "response" : {
//        "exterior_color" : "Black",
//        "center_display_state" : 0,
//        "autopark_style" : "dead_man",
//        "remote_start" : false,
//        "odometer" : 728.37821299999996,
//        "rt" : 0,
//        "sun_roof_percent_open" : 0,
//        "vehicle_name" : "Darth",
//        "remote_start_supported" : true,
//        "dark_rims" : false,
//        "locked" : true,
//        "rear_seat_type" : 0,
//        "rhd" : false,
//        "autopark_state_v2" : "disabled",
//        "roof_color" : "Glass",
//        "rear_seat_heaters" : 0,
//        "valet_mode" : false,
//        "parsed_calendar_supported" : true,
//        "api_version" : 3,
//        "homelink_nearby" : false,
//        "autopark_state" : "unavailable",
//        "last_autopark_error" : "no_error",
//        "dr" : 0,
//        "has_spoiler" : false,
//        "calendar_supported" : true,
//        "sun_roof_state" : "unknown",
//        "df" : 0,
//        "valet_pin_needed" : true,
//        "pr" : 0,
//        "spoiler_type" : "None",
//        "car_type" : "models2",
//        "perf_config" : "P2",
//        "car_version" : "2017.44 02fdc86",
//        "seat_type" : 2,
//        "third_row_seats" : "None",
//        "ft" : 0,
//        "notifications_supported" : true,
//        "pf" : 0,
//        "wheel_type" : "AeroTurbine19",
//        "sun_roof_installed" : 0,
//        "timestamp" : 1511681566934
//    }
//}

