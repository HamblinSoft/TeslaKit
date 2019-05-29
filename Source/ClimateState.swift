//
//  ClimateState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response object containing information about the current temperature and climate control state of a vehicle
public class ClimateState: JSONDecodable {

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
    public var isAutoConditioningOn: Int = 0

    ///
    public var isPreconditioning: Int = 0

    ///
    public var sideMirrorHeaters: Int = 0

    ///
    public var batteryHeaterNoPower: Int = 0

    ///
    public var steeringWheelHeater: Int = 0

    ///
    public var batteryHeater: Int = 0

    ///
    public var wiperBladeHeater: Int = 0

    ///
    public var climateKeeperMode: Bool = false

    ///
    public var remoteHeaterControlEnabled: Bool = false

    ///
    public init() {}

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

