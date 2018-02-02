//
//  TKChargeState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response object containing information about the charge state of the vehicle
public struct TKChargeState {

    ///
    public var chargingState: TKChargingState = TKChargingState.stopped

    ///
    public var chargeToMaxRange: Bool = false

    ///
    public var fastChargerPresent: Bool = false

    ///
    public var batteryRange: Double = 0.0

    ///
    public var estBatteryRange: Double = 0.0

    ///
    public var idealBatteryRange: Double = 0.0

    ///
    public var batteryLevel: Double = 0.0

    ///
    public var timeToFullCharge: Double = 0.0

    ///
    public var chargePortDoorOpen: Bool = false

//    public var fast_charger_type: String? = nil
//    public var user_charge_enable_request: String? = nil

    /// The amount of kH added
    public var chargeEnergyAdded: Double = 0

    /// The maximum charge current that can be requested
    public var chargeCurrentRequestMax: Int = 0

//    public var charger_phases: String? = nil
//    public var battery_heater_on: String? = nil
//    public var motorized_charge_port: Bool = false
//    public var trip_charging: Bool = false
//    public var charge_enable_request: Bool = false
//    public var charge_limit_soc_std: Int = 0

    /// The actual current provided by the charger
    public var chargerActualCurrent: Int = 0

//    public var charge_port_latch: String? = nil
//    public var charge_current_request: Int = 0

    /// The voltage of the charger
    public var chargerVoltage: Int = 0

//    public var managed_charging_active: Bool = false
//    public var charger_pilot_current: Int = 0
//    public var charge_rate: Int = 0
//    public var charge_limit_soc_max: Int = 0
//    public var charge_limit_soc_min: Int = 0
//    public var usable_battery_level: Int = 0
//    public var max_range_charge_counter: Int = 0

    /// The start time of the scheduled charging
    public var scheduledChargingStartTime: TimeInterval? = nil

//    public var charger_power: Int = 0
//    public var scheduled_charging_pending: Bool = false

    public var notEnoughPowerToHeat: Bool = false
//    public var managed_charging_start_time: String? = nil

    ///
    public var charge_miles_added_rated: Double = 0
//    public var charge_miles_added_ideal: Int = 0
//    public var managed_charging_user_canceled: Bool = false
//    public var charge_limit_soc: Int = 0
//    public var eu_vehicle: Bool = false
//    public var timestamp: Int = 0


    /// Returns whether the vehicle is connected to a charger or not
    public var isChargerConnected: Bool { return self.chargingState != .disconnected }

    ///
    public init() {}
}

extension TKChargeState: TKDataResponse {
    public mutating func mapping(map: Map) {
        chargingState <- (map["charging_state"], EnumTransform())
        chargeToMaxRange <- map["charge_to_max_range"]
        fastChargerPresent <- map["fast_charger_present"]
        batteryRange <- map["battery_range"]
        estBatteryRange <- map["est_battery_range"]
        idealBatteryRange <- map["ideal_battery_range"]
        batteryLevel <- map["battery_level"]
        timeToFullCharge <- map["time_to_full_charge"]
        chargePortDoorOpen <- map["charge_port_door_open"]
        charge_miles_added_rated <- map["charge_miles_added_rated"]
        chargerActualCurrent <- map["charger_actual_current"]
        chargerVoltage <- map["charger_voltage"]
        chargeCurrentRequestMax <- map["charge_current_request_max"]
        scheduledChargingStartTime <- map["scheduled_charging_start_time"]
        chargeEnergyAdded <- map["charge_energy_added"]
        notEnoughPowerToHeat <- map["not_enough_power_to_heat"]
    }
}

//{
//    "fast_charger_type" : "<invalid>",
//    "timestamp" : 1513809833054,
//    "est_battery_range" : 202.59999999999999,
//    "user_charge_enable_request" : null,
//    "charge_energy_added" : 9.0700000000000003,
//    "charge_current_request_max" : 48,
//    "charger_phases" : null,
//    "fast_charger_present" : false,
//    "battery_heater_on" : null,
//    "time_to_full_charge" : 0,
//    "motorized_charge_port" : true,
//    "trip_charging" : false,
//    "battery_range" : 211.05000000000001,
//    "charge_port_door_open" : false,
//    "charge_enable_request" : true,
//    "charge_limit_soc_std" : 90,
//    "charger_actual_current" : 0,
//    "charge_port_latch" : "Engaged",
//    "charge_current_request" : 48,
//    "charger_voltage" : 0,
//    "managed_charging_active" : false,
//    "charger_pilot_current" : 48,
//    "charge_rate" : 0,
//    "charge_limit_soc_max" : 100,
//    "charge_limit_soc_min" : 50,
//    "usable_battery_level" : 87,
//    "ideal_battery_range" : 264.25999999999999,
//    "max_range_charge_counter" : 2,
//    "scheduled_charging_start_time" : null,
//    "charger_power" : 0,
//    "scheduled_charging_pending" : false,
//    "not_enough_power_to_heat" : false,
//    "managed_charging_start_time" : null,
//    "charge_miles_added_rated" : 30.5,
//    "battery_level" : 87,
//    "charge_to_max_range" : true,
//    "charge_miles_added_ideal" : 38,
//    "managed_charging_user_canceled" : false,
//    "charge_limit_soc" : 94,
//    "eu_vehicle" : false,
//    "charging_state" : "Disconnected"
//}

