//
//  VehicleConfig.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public final class VehicleConfig: JSONDecodable {

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
    public var keyVersion: Int = 0

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.wheelType = try decoder.decodeIfPresent(CodingKeys.wheelType)
        self.sunRoofInstalled = try decoder.decodeIfPresent(CodingKeys.sunRoofInstalled) ?? 0
        self.seatType = try decoder.decodeIfPresent(CodingKeys.seatType) ?? 0
        self.rearSeatType = try decoder.decodeIfPresent(CodingKeys.rearSeatType) ?? 0
        self.roofColor = try decoder.decodeIfPresent(CodingKeys.roofColor)
        self.perfConfig = try decoder.decodeIfPresent(CodingKeys.perfConfig)
        self.rhd = try decoder.decodeIfPresent(CodingKeys.rhd) ?? false
        self.spoilerType = try decoder.decodeIfPresent(CodingKeys.spoilerType)
        self.carSpecialType = try decoder.decodeIfPresent(CodingKeys.carSpecialType)
        self.hasLudicrousMode = try decoder.decodeIfPresent(CodingKeys.hasLudicrousMode) ?? false
        self.timestamp = try decoder.decodeIfPresent(CodingKeys.timestamp) ?? 0
        self.plg = try decoder.decodeIfPresent(CodingKeys.plg) ?? false
        self.motorizedChargePort = try decoder.decodeIfPresent(CodingKeys.motorizedChargePort) ?? false
        self.euVehicle = try decoder.decodeIfPresent(CodingKeys.euVehicle) ?? false
        self.rearSeatHeaters = try decoder.decodeIfPresent(CodingKeys.rearSeatHeaters) ?? 0
        self.thirdRowSeats = try decoder.decodeIfPresent(CodingKeys.thirdRowSeats)
        self.canActuateTrunks = try decoder.decodeIfPresent(CodingKeys.canActuateTrunks) ?? false
        self.carType = try decoder.decodeIfPresent(CodingKeys.carType)
        self.chargePortType = try decoder.decodeIfPresent(CodingKeys.chargePortType)
        self.exteriorColor = try decoder.decodeIfPresent(CodingKeys.exteriorColor)
        self.canAcceptNavigationRequests = try decoder.decodeIfPresent(CodingKeys.canAcceptNavigationRequests) ?? false
        self.hasAirSuspension = try decoder.decodeIfPresent(CodingKeys.hasAirSuspension) ?? false
        self.keyVersion = try decoder.decodeIfPresent(CodingKeys.keyVersion) ?? 0
    }

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


