//
//  TKVehicleConfig.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleConfig {

    ///
    public var wheel_type: String? = nil

    ///
    public var sun_roof_installed: Int = 0

    ///
    public var trimBadging: String = ""

    ///
    public var seat_type: Int = 0

    ///
    public var rear_seat_type: Int = 0

    ///
    public var roof_color: String? = nil

    ///
    public var perf_config: String? = nil

    ///
    public var rhd: Bool = false

    ///
    public var spoiler_type: String? = nil

    ///
    public var car_special_type: String? = nil

    ///
    public var has_ludicrous_mode: Bool = false

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var plg: Bool = false

    ///
    public var motorizedChargePort: Bool = false

    ///
    public var eu_vehicle: Bool = false

    ///
    public var rear_seat_heaters: Int = 0

    ///
    public var third_row_seats: String? = nil

    ///
    public var can_actuate_trunks: Bool = false

    ///
    public var car_type: String? = nil

    ///
    public var charge_port_type: String? = nil

    ///
    public var exterior_color: String? = nil

    ///
    public init() {}
}

extension TKVehicleConfig: TKMappable {
    public mutating func mapping(map: Map) {
        trimBadging <- map["trim_badging"]
        motorizedChargePort <- map["motorized_charge_port"]
    }
}


//{
//    "plg" : true,
//    "spoiler_type" : "None",
//    "motorized_charge_port" : true,
//    "can_actuate_trunks" : false,
//    "eu_vehicle" : false,
//    "rear_seat_heaters" : 0,
//    "rear_seat_type" : 0,
//    "third_row_seats" : "None",
//    "car_special_type" : "base",
//    "timestamp" : 1516240723415,
//    "car_type" : "models2",
//    "charge_port_type" : "US",
//    "sun_roof_installed" : 0,
//    "wheel_type" : "AeroTurbine19",
//    "exterior_color" : "Black",
//    "perf_config" : "P2",
//    "trim_badging" : "75",
//    "roof_color" : "Glass",
//    "seat_type" : 2,
//    "rhd" : false,
//    "has_ludicrous_mode" : false
//}


