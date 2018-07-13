//
//  TKVehicleState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleState {

    ///
    public var exteriorColor: String?

    // TODO: Complete other properties

    ///
    public var centerDisplayState: Int = 0

    ///
    public var autoparkStyle: String? = nil

    /// Returns whether remote start is active (Driver can begin keyless driving by entering the car, pressing the brake, and selecting Drive)
    public var remoteStart: Bool = false

    ///
    public var odometer: Double = 0

    ///
    public var rearTrunkState: Int = 0

    ///
    public var sunRoofPercentOpen: Int = 0

    ///
    public var vehicleName: String? = nil

    ///
    public var remoteStartSupported: Bool = false

    ///
    public var darkRims: Bool = false

    ///
    public var locked: Bool = false

    ///
    public var rearSeatType: Int = 0

    ///
    public var rhd: Bool = false

    ///
    public var autoparkStateV2: String? = nil

    ///
    public var roofColor: String? = nil

    ///
    public var rearSeatHeaters: Int = 0

    /// Returns whether valet mode is current enabled
    public var valetMode: Bool = false

    ///
    public var parsedCalendarSupported: Bool = false

    ///
    public var apiVersion: Int = 0

    ///
    public var homelinkNearby: Bool = false

    ///
    public var autoparkState: String? = nil

    ///
    public var lastAutoparkError: String? = nil

    ///
    public var driverRearDoorState: Int = 0

    ///
    public var hasSpoiler: Bool = false

    ///
    public var calendarSupported: Bool = false

    ///
    public var sunRoofState: String? = nil

    ///
    public var driverFrontDoorState: Int = 0

    /// Returns whether valet mode requires PIN
    public var valetPinNeeded: Bool = false

    ///
    public var passengerRearDoorState: Int = 0

    ///
    public var spoilerType: String? = nil

    ///
    public var carType: String? = nil

    ///
    public var perfConfig: String? = nil

    ///
    public var carVersion: String? = nil

    ///
    public var seatType: Int = 0

    ///
    public var thirdRowSeats: String? = nil

    ///
    public var frontTrunkState: Int = 0

    ///
    public var notificationsSupported: Bool = false

    ///
    public var passengerFrontDoorState: Int = 0

    ///
    public var wheelType: String? = nil

    ///
    public var sunRoofInstalled: Int = 0

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var speedLimitMode: TKSpeedLimitMode = TKSpeedLimitMode()

    ///
    public init() {}
}

extension TKVehicleState: TKDataResponse {

    public mutating func mapping(map: Map) {
        apiVersion <- map["api_version"]
        autoparkState <- map["autopark_state"]
        autoparkStateV2 <- map["autopark_state_v2"]
        autoparkStyle <- map["autopark_style"]
        calendarSupported <- map["calendar_supported"]
        carType <- map["car_type"]
        carVersion <- map["car_version"]
        centerDisplayState <- map["center_display_state"]
        darkRims <- map["dark_rims"]
        driverFrontDoorState <- map["df"]
        driverRearDoorState <- map["dr"]
        exteriorColor <- map["exterior_color"]
        frontTrunkState <- map["ft"]
        hasSpoiler <- map["has_spoiler"]
        homelinkNearby <- map["homelink_nearby"]
        lastAutoparkError <- map["last_autopark_error"]
        notificationsSupported <- map["notifications_supported"]
        odometer <- map["odometer"]
        parsedCalendarSupported <- map["parsed_calendar_supported"]
        passengerFrontDoorState <- map["pf"]
        passengerRearDoorState <- map["pr"]
        perfConfig <- map["perf_config"]
        rearSeatHeaters <- map["rear_seat_heaters"]
        rearSeatType <- map["rear_seat_type"]
        rearTrunkState <- map["rt"]
        remoteStart <- map["remote_start"]
        remoteStartSupported <- map["remote_start_supported"]
        rhd <- map["rhd"]
        roofColor <- map["roof_color"]
        seatType <- map["seat_type"]
        spoilerType <- map["spoiler_type"]
        sunRoofInstalled <- map["sun_roof_installed"]
        sunRoofPercentOpen <- map["sun_roof_percent_open"]
        sunRoofState <- map["sun_roof_state"]
        thirdRowSeats <- map["third_row_seats"]
        timestamp <- map["timestamp"]
        valetMode <- map["valet_mode"]
        valetPinNeeded <- map["valet_pin_needed"]
        vehicleName <- map["vehicle_name"]
        wheelType <- map["wheel_type"]
        locked <- map["locked"]
        speedLimitMode <- map["speed_limit_mode"]
    }
}

//{
//    "exterior_color" : "Black",
//    "center_display_state" : 0,
//    "autopark_style" : "dead_man",
//    "remote_start" : false,
//    "odometer" : 1300.683614,
//    "rt" : 0,
//    "sun_roof_percent_open" : 0,
//    "vehicle_name" : "Darth",
//    "remote_start_supported" : true,
//    "dark_rims" : false,
//    "locked" : true,
//    "rear_seat_type" : 0,
//    "rhd" : false,
//    "autopark_state_v2" : "disabled",
//    "roof_color" : "Glass",
//    "rear_seat_heaters" : 0,
//    "valet_mode" : false,
//    "parsed_calendar_supported" : true,
//    "api_version" : 3,
//    "homelink_nearby" : false,
//    "autopark_state" : "unavailable",
//    "last_autopark_error" : "no_error",
//    "dr" : 0,
//    "has_spoiler" : false,
//    "calendar_supported" : true,
//    "sun_roof_state" : "unknown",
//    "df" : 0,
//    "valet_pin_needed" : true,
//    "pr" : 0,
//    "spoiler_type" : "None",
//    "car_type" : "models2",
//    "perf_config" : "P2",
//    "car_version" : "2017.44 02fdc86",
//    "seat_type" : 2,
//    "third_row_seats" : "None",
//    "ft" : 0,
//    "notifications_supported" : true,
//    "pf" : 0,
//    "wheel_type" : "AeroTurbine19",
//    "sun_roof_installed" : 0,
//    "timestamp" : 1513809833025
//}


