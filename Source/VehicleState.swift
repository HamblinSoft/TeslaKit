//
//  VehicleState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public final class VehicleState: JSONDecodable {

    ///
    public var exteriorColor: String?

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
    public var isUserPresent: Bool = false

    /// Indicates whether sentry mode is activated
    public var sentryMode: Bool = false

    ///
    public var speedLimitMode: SpeedLimitMode = SpeedLimitMode()

    ///
    public var softwareUpdate: SoftwareUpdate = SoftwareUpdate()

    ///
    public var mediaState: MediaState = MediaState()

    ///
    public var autoParkStateV3: String = ""

    ///
    public var remoteStartEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.exteriorColor = try decoder.decodeIfPresent(CodingKeys.exteriorColor)
        self.centerDisplayState = try decoder.decodeIfPresent(CodingKeys.centerDisplayState) ?? 0
        self.autoparkStyle = try decoder.decodeIfPresent(CodingKeys.autoparkStyle)
        self.remoteStart = try decoder.decodeIfPresent(CodingKeys.remoteStart) ?? false
        self.odometer = try decoder.decodeIfPresent(CodingKeys.odometer) ?? 0
        self.rearTrunkState = try decoder.decodeIfPresent(CodingKeys.rearTrunkState) ?? 0
        self.sunRoofPercentOpen = try decoder.decodeIfPresent(CodingKeys.sunRoofPercentOpen) ?? 0
        self.vehicleName = try decoder.decodeIfPresent(CodingKeys.vehicleName)
        self.remoteStartSupported = try decoder.decodeIfPresent(CodingKeys.remoteStartSupported) ?? false
        self.locked = try decoder.decodeIfPresent(CodingKeys.locked) ?? false
        self.rearSeatType = try decoder.decodeIfPresent(CodingKeys.rearSeatType) ?? 0
        self.rhd = try decoder.decodeIfPresent(CodingKeys.rhd) ?? false
        self.autoparkStateV2 = try decoder.decodeIfPresent(CodingKeys.autoparkStateV2)
        self.roofColor = try decoder.decodeIfPresent(CodingKeys.roofColor)
        self.rearSeatHeaters = try decoder.decodeIfPresent(CodingKeys.rearSeatHeaters) ?? 0
        self.valetMode = try decoder.decodeIfPresent(CodingKeys.valetMode) ?? false
        self.parsedCalendarSupported = try decoder.decodeIfPresent(CodingKeys.parsedCalendarSupported) ?? false
        self.apiVersion = try decoder.decodeIfPresent(CodingKeys.apiVersion) ?? 0
        self.homelinkNearby = try decoder.decodeIfPresent(CodingKeys.homelinkNearby) ?? false
        self.autoparkState = try decoder.decodeIfPresent(CodingKeys.autoparkState)
        self.lastAutoparkError = try decoder.decodeIfPresent(CodingKeys.lastAutoparkError)
        self.driverRearDoorState = try decoder.decodeIfPresent(CodingKeys.driverRearDoorState) ?? 0
        self.calendarSupported = try decoder.decodeIfPresent(CodingKeys.calendarSupported) ?? false
        self.sunRoofState = try decoder.decodeIfPresent(CodingKeys.sunRoofState)
        self.driverFrontDoorState = try decoder.decodeIfPresent(CodingKeys.driverFrontDoorState) ?? 0
        self.valetPinNeeded = try decoder.decodeIfPresent(CodingKeys.valetPinNeeded) ?? false
        self.passengerRearDoorState = try decoder.decodeIfPresent(CodingKeys.passengerRearDoorState) ?? 0
        self.spoilerType = try decoder.decodeIfPresent(CodingKeys.spoilerType)
        self.carType = try decoder.decodeIfPresent(CodingKeys.carType)
        self.perfConfig = try decoder.decodeIfPresent(CodingKeys.perfConfig)
        self.carVersion = try decoder.decodeIfPresent(CodingKeys.carVersion)
        self.seatType = try decoder.decodeIfPresent(CodingKeys.seatType) ?? 0
        self.thirdRowSeats = try decoder.decodeIfPresent(CodingKeys.thirdRowSeats)
        self.frontTrunkState = try decoder.decodeIfPresent(CodingKeys.frontTrunkState) ?? 0
        self.notificationsSupported = try decoder.decodeIfPresent(CodingKeys.notificationsSupported) ?? false
        self.passengerFrontDoorState = try decoder.decodeIfPresent(CodingKeys.passengerFrontDoorState) ?? 0
        self.wheelType = try decoder.decodeIfPresent(CodingKeys.wheelType)
        self.sunRoofInstalled = try decoder.decodeIfPresent(CodingKeys.sunRoofInstalled) ?? 0
        self.timestamp = try decoder.decodeIfPresent(CodingKeys.timestamp) ?? 0
        self.isUserPresent = try decoder.decodeIfPresent(CodingKeys.isUserPresent) ?? false
        self.sentryMode = try decoder.decodeIfPresent(CodingKeys.sentryMode) ?? false
        self.speedLimitMode = try decoder.decodeIfPresent(CodingKeys.speedLimitMode) ?? SpeedLimitMode()
        self.softwareUpdate = try decoder.decodeIfPresent(CodingKeys.softwareUpdate) ?? SoftwareUpdate()
        self.mediaState = try decoder.decodeIfPresent(CodingKeys.mediaState) ?? MediaState()
        self.autoParkStateV3 = try decoder.decodeIfPresent(CodingKeys.autoParkStateV3) ?? ""
        self.remoteStartEnabled = try decoder.decodeIfPresent(CodingKeys.remoteStartEnabled) ?? false
    }

    ///
    public var isRearTrunkOpen: Bool { return rearTrunkState != 0 }

    ///
    public var isFrontTrunkOpen: Bool { return frontTrunkState != 0 }

    ///
    public var isDriverFrontDoorOpen: Bool { return driverFrontDoorState != 0 }

    ///
    public var isDriverRearDoorOpen: Bool { return driverRearDoorState != 0 }

    ///
    public var isPassengerFrontDoorOpen: Bool { return passengerFrontDoorState != 0 }

    ///
    public var isPassengerRearDoorOpen: Bool { return passengerRearDoorState != 0 }

    private enum CodingKeys: String, CodingKey {
        case apiVersion = "api_version"
        case autoparkState = "autopark_state"
        case autoparkStateV2 = "autopark_state_v2"
        case autoparkStyle = "autopark_style"
        case calendarSupported = "calendar_supported"
        case carType = "car_type"
        case carVersion = "car_version"
        case centerDisplayState = "center_display_state"
        case driverFrontDoorState = "df"
        case driverRearDoorState = "dr"
        case exteriorColor = "exterior_color"
        case frontTrunkState = "ft"
        case homelinkNearby = "homelink_nearby"
        case lastAutoparkError = "last_autopark_error"
        case notificationsSupported = "notifications_supported"
        case odometer = "odometer"
        case parsedCalendarSupported = "parsed_calendar_supported"
        case passengerFrontDoorState = "pf"
        case passengerRearDoorState = "pr"
        case perfConfig = "perf_config"
        case rearSeatHeaters = "rear_seat_heaters"
        case rearSeatType = "rear_seat_type"
        case rearTrunkState = "rt"
        case remoteStart = "remote_start"
        case remoteStartSupported = "remote_start_supported"
        case rhd = "rhd"
        case roofColor = "roof_color"
        case seatType = "seat_type"
        case spoilerType = "spoiler_type"
        case sunRoofInstalled = "sun_roof_installed"
        case sunRoofPercentOpen = "sun_roof_percent_open"
        case sunRoofState = "sun_roof_state"
        case thirdRowSeats = "third_row_seats"
        case timestamp = "timestamp"
        case valetMode = "valet_mode"
        case valetPinNeeded = "valet_pin_needed"
        case vehicleName = "vehicle_name"
        case wheelType = "wheel_type"
        case locked = "locked"
        case isUserPresent = "is_user_present"
        case speedLimitMode = "speed_limit_mode"
        case softwareUpdate = "software_update"
        case mediaState = "media_state"
        case sentryMode = "sentry_mode"
        case autoParkStateV3 = "autopark_state_v3"
        case remoteStartEnabled = "remote_start_enabled"
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


