//
//  ClimateState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response object containing information about the current temperature and climate control state of a vehicle
public final class ClimateState: JSONDecodable {

    ///
    public var seatHeaterLeft: Int = 0

    ///
    public var fanStatus: Int = 0

    ///
    public var isFrontDefrosterOn: Bool = false

    ///
    public var isRearDefrosterOn: Bool = false

    ///
    public var isClimateOn: Bool = false

    ///
    public var seatHeaterRearLeft: Int = 0

    ///
    public var minimumAvailableTemperature: Double = 0

    ///
    public var insideTemperature: Double? = nil

    ///
    public var driverTemperatureSetting: Double = 0

    ///
    public var passengerTemperatureSetting: Double = 0

    ///
    public var outsideTemperature: Double? = nil

    ///
    public var seatHeaterRearCenter: Int = 0

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var rightTemperatureDirection: Int? = nil

    ///
    public var leftTemperatureDirection: Int? = nil

    ///
    public var seatHeaterRearRight: Int = 0

    ///
    public var seatHeaterRearRightBack: Int = 0

    ///
    public var seatHeaterRight: Int = 0

    ///
    public var seatHeaterRearLeftBack: Int = 0

    ///
    public var smartPreconditioning: Bool = false

    ///
    public var maximumAvailableTemperature: Double = 0

    ///
    public var isAutoConditioningOn: Bool = false

    ///
    public var isPreconditioning: Bool = false

    ///
    public var sideMirrorHeaters: Bool = false

    ///
    public var batteryHeaterNoPower: Int = 0

    ///
    public var steeringWheelHeater: Int = 0

    ///
    public var batteryHeater: Bool = false

    ///
    public var wiperBladeHeater: Bool = false

    ///
    public var climateKeeperMode: String = "off"

    ///
    public var remoteHeaterControlEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.seatHeaterLeft = try decoder.decodeIfPresent(CodingKeys.seatHeaterLeft) ?? 0
        self.fanStatus = try decoder.decodeIfPresent(CodingKeys.fanStatus) ?? 0
        self.isFrontDefrosterOn = try decoder.decodeIfPresent(CodingKeys.isFrontDefrosterOn) ?? false
        self.isRearDefrosterOn = try decoder.decodeIfPresent(CodingKeys.isRearDefrosterOn) ?? false
        self.isClimateOn = try decoder.decodeIfPresent(CodingKeys.isClimateOn) ?? false
        self.seatHeaterRearLeft = try decoder.decodeIfPresent(CodingKeys.seatHeaterRearLeft) ?? 0
        self.minimumAvailableTemperature = try decoder.decodeIfPresent(CodingKeys.minimumAvailableTemperature) ?? 0
        self.insideTemperature = try decoder.decodeIfPresent(CodingKeys.insideTemperature)
        self.driverTemperatureSetting = try decoder.decodeIfPresent(CodingKeys.driverTemperatureSetting) ?? 0
        self.passengerTemperatureSetting = try decoder.decodeIfPresent(CodingKeys.passengerTemperatureSetting) ?? 0
        self.outsideTemperature = try decoder.decodeIfPresent(CodingKeys.outsideTemperature)
        self.seatHeaterRearCenter = try decoder.decodeIfPresent(CodingKeys.seatHeaterRearCenter) ?? 0
        self.timestamp = try decoder.decodeIfPresent(CodingKeys.timestamp) ?? 0
        self.rightTemperatureDirection = try decoder.decodeIfPresent(CodingKeys.rightTemperatureDirection)
        self.leftTemperatureDirection = try decoder.decodeIfPresent(CodingKeys.leftTemperatureDirection)
        self.seatHeaterRearRight = try decoder.decodeIfPresent(CodingKeys.seatHeaterRearRight) ?? 0
        self.seatHeaterRearRightBack = try decoder.decodeIfPresent(CodingKeys.seatHeaterRearRightBack) ?? 0
        self.seatHeaterRight = try decoder.decodeIfPresent(CodingKeys.seatHeaterRight) ?? 0
        self.seatHeaterRearLeftBack = try decoder.decodeIfPresent(CodingKeys.seatHeaterRearLeftBack) ?? 0
        self.smartPreconditioning = try decoder.decodeIfPresent(CodingKeys.smartPreconditioning) ?? false
        self.maximumAvailableTemperature = try decoder.decodeIfPresent(CodingKeys.maximumAvailableTemperature) ?? 0
        self.isAutoConditioningOn = try decoder.decodeIfPresent(CodingKeys.isAutoConditioningOn) ?? false
        self.isPreconditioning = try decoder.decodeIfPresent(CodingKeys.isPreconditioning) ?? false
        self.sideMirrorHeaters = try decoder.decodeIfPresent(CodingKeys.sideMirrorHeaters) ?? false
        self.batteryHeaterNoPower = try decoder.decodeIfPresent(CodingKeys.batteryHeaterNoPower) ?? 0
        self.steeringWheelHeater = try decoder.decodeIfPresent(CodingKeys.steeringWheelHeater) ?? 0
        self.batteryHeater = try decoder.decodeIfPresent(CodingKeys.batteryHeater) ?? false
        self.wiperBladeHeater = try decoder.decodeIfPresent(CodingKeys.wiperBladeHeater) ?? false
        self.climateKeeperMode = try decoder.decodeIfPresent(CodingKeys.climateKeeperMode) ?? "off"
        self.remoteHeaterControlEnabled = try decoder.decodeIfPresent(CodingKeys.remoteHeaterControlEnabled) ?? false
    }

    private enum CodingKeys: String, CodingKey {
        case driverTemperatureSetting = "driver_temp_setting"
        case fanStatus = "fan_status"
        case insideTemperature = "inside_temp"
        case isAutoConditioningOn = "is_auto_conditioning_on"
        case isClimateOn = "is_climate_on"
        case isFrontDefrosterOn = "is_front_defroster_on"
        case isRearDefrosterOn = "is_rear_defroster_on"
        case leftTemperatureDirection = "left_temp_direction"
        case maximumAvailableTemperature = "max_avail_temp"
        case minimumAvailableTemperature = "min_avail_temp"
        case outsideTemperature = "outside_temp"
        case passengerTemperatureSetting = "passenger_temp_setting"
        case rightTemperatureDirection = "right_temp_direction"
        case seatHeaterRearCenter = "seat_heater_rear_center"
        case seatHeaterRearLeft = "seat_heater_rear_left"
        case seatHeaterRearLeftBack = "seat_heater_rear_left_back"
        case seatHeaterRearRight = "seat_heater_rear_right"
        case seatHeaterRearRightBack = "seat_heater_rear_right_back"
        case seatHeaterRight = "seat_heater_right"
        case smartPreconditioning = "smart_preconditioning"
        case timestamp = "timestamp"
        case seatHeaterLeft = "seat_heater_left"
        case isPreconditioning = "is_preconditioning"
        case sideMirrorHeaters = "side_mirror_heaters"
        case batteryHeaterNoPower = "battery_heater_no_power"
        case steeringWheelHeater = "steering_wheel_heater"
        case batteryHeater = "battery_heater"
        case wiperBladeHeater = "wiper_blade_heater"
        case climateKeeperMode = "climate_keeper_mode"
        case remoteHeaterControlEnabled = "remote_heater_control_enabled"
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

