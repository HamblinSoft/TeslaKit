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
    public var wheelType: String? = nil

    ///
    public var sunRoofInstalled: Int = 0

    ///
    public var trimBadging: String = ""

    ///
    public var seatType: Int = 0

    ///
    public var rearSeatType: Int = 0

    ///
    public var roofColor: String? = nil

    ///
    public var perfConfig: String? = nil

    ///
    public var rhd: Bool = false

    ///
    public var spoilerType: String? = nil

    ///
    public var carSpecialType: String? = nil

    ///
    public var hasLudicrousMode: Bool = false

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var plg: Bool = false

    ///
    public var motorizedChargePort: Bool = false

    ///
    public var euVehicle: Bool = false

    ///
    public var rearSeatHeaters: Int = 0

    ///
    public var thirdRowSeats: String? = nil

    ///
    public var canActuateTrunks: Bool = false

    ///
    public var carType: String? = nil

    ///
    public var chargePortType: String? = nil

    ///
    public var exteriorColor: String? = nil

    ///
    public init() {}
}

extension TKVehicleConfig: TKMappable {
    public mutating func mapping(map: Map) {
        canActuateTrunks <- map["can_actuate_trunks"]
        carSpecialType <- map["car_special_type"]
        carType <- map["car_type"]
        chargePortType <- map["charge_port_type"]
        euVehicle <- map["eu_vehicle"]
        exteriorColor <- map["exterior_color"]
        hasLudicrousMode <- map["has_ludicrous_mode"]
        motorizedChargePort <- map["motorized_charge_port"]
        perfConfig <- map["perf_config"]
        plg <- map["plg"]
        rearSeatHeaters <- map["rear_seat_heaters"]
        rearSeatType <- map["rear_seat_type"]
        rhd <- map["rhd"]
        roofColor <- map["roof_color"]
        seatType <- map["seat_type"]
        spoilerType <- map["spoiler_type"]
        sunRoofInstalled <- map["sun_roof_installed"]
        thirdRowSeats <- map["third_row_seats"]
        timestamp <- map["timestamp"]
        trimBadging <- map["trim_badging"]
        wheelType <- map["wheel_type"]
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


