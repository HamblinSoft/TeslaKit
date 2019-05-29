//
//  VehicleConfig.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public class VehicleConfig: JSONDecodable {

    ///
    public var wheelType: String? = nil

    ///
    public var sunRoofInstalled: Int = 0

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
    public var canAcceptNavigationRequests: Bool = false

    ///
    public var hasAirSuspension: Bool = false

    ///
    public var keyVersion: String = ""

    ///
    public init() {}

    private enum CodingKeys: String, CodingKey {
        case canActuateTrunks = "can_actuate_trunks"
        case carSpecialType = "car_special_type"
        case carType = "car_type"
        case chargePortType = "charge_port_type"
        case euVehicle = "eu_vehicle"
        case exteriorColor = "exterior_color"
        case hasLudicrousMode = "has_ludicrous_mode"
        case motorizedChargePort = "motorized_charge_port"
        case perfConfig = "perf_config"
        case plg = "plg"
        case rearSeatHeaters = "rear_seat_heaters"
        case rearSeatType = "rear_seat_type"
        case rhd = "rhd"
        case roofColor = "roof_color"
        case seatType = "seat_type"
        case spoilerType = "spoiler_type"
        case sunRoofInstalled = "sun_roof_installed"
        case thirdRowSeats = "third_row_seats"
        case timestamp = "timestamp"
        case wheelType = "wheel_type"
        case canAcceptNavigationRequests = "can_accept_navigation_requests"
        case hasAirSuspension = "has_air_suspension"
        case keyVersion = "key_version"
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


