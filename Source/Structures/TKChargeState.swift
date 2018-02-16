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

    ///
    public var fastChargerType: String? = nil
    
    ///
    public var userChargeEnableRequest: String? = nil

    /// The amount of kH added
    public var chargeEnergyAdded: Double = 0

    /// The maximum charge current that can be requested
    public var chargeCurrentRequestMax: Int = 0

    ///
    public var chargerPhases: String? = nil
    
    ///
    public var batteryHeaterOn: String? = nil
    
    ///
    public var motorizedChargePort: Bool = false
    
    ///
    public var tripCharging: Bool = false
    
    ///
    public var chargeEnableRequest: Bool = false
    
    ///
    public var chargeLimitSocStd: Int = 0

    /// The actual current provided by the charger
    public var chargerActualCurrent: Int = 0

    ///
    public var chargePortLatch: TKChargePortLatchState = TKChargePortLatchState.unknown
    
    ///
    public var chargeCurrentRequest: Int = 0

    /// The voltage of the charger
    public var chargerVoltage: Int = 0

    ///
    public var managedChargingActive: Bool = false
    
    ///
    public var chargerPilotCurrent: Int = 0
    
    ///
    public var chargeRate: Int = 0
    
    ///
    public var chargeLimitSocMax: Int = 0
    
    ///
    public var chargeLimitSocMin: Int = 0
    
    ///
    public var usableBatteryLevel: Int = 0
    
    ///
    public var maxRangeChargeCounter: Int = 0

    /// The start time of the scheduled charging
    public var scheduledChargingStartTime: TimeInterval? = nil

    ///
    public var chargerPower: Int = 0
    
    ///
    public var scheduledChargingPending: Bool = false

    ///
    public var notEnoughPowerToHeat: Bool = false
    
    ///
    public var managedChargingStartTime: String? = nil

    ///
    public var chargeMilesAddedRated: Double = 0
    
    ///
    public var chargeMilesAddedIdeal: Double = 0
    
    ///
    public var managedChargingUserCanceled: Bool = false
    
    ///
    public var chargeLimitSoc: Int = 0
    
    ///
    public var euVehicle: Bool = false
    
    ///
    public var timeStamp: TimeInterval = 0


    /// Returns whether the vehicle is connected to a charger or not
    public var isChargerConnected: Bool { return self.chargingState != .disconnected }

    /// Returns whether the vehicle is improperly connected to a charger
    public var isChargerImproperlyConnected: Bool { return self.isChargerConnected && self.chargePortLatch == .disengaged }

    /// Returns whether the vehicle is charging or will begin charging
    public var isCharging: Bool { return self.chargingState == .starting || self.chargingState == .charging }

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
        chargeMilesAddedRated <- map["charge_miles_added_rated"]
        chargerActualCurrent <- map["charger_actual_current"]
        chargerVoltage <- map["charger_voltage"]
        chargeCurrentRequestMax <- map["charge_current_request_max"]
        scheduledChargingStartTime <- map["scheduled_charging_start_time"]
        chargeEnergyAdded <- map["charge_energy_added"]
        notEnoughPowerToHeat <- map["not_enough_power_to_heat"]
        managedChargingActive <- map["managed_charging_active"]
        fastChargerType <- map["fast_charger_type"]
        userChargeEnableRequest <- map["user_charge_enable_request"]
        chargerPhases <- map["charger_phases"]
        batteryHeaterOn <- map["battery_heater_on"]
        motorizedChargePort <- map["motorized_charge_port"]
        tripCharging <- map["trip_charging"]
        chargeEnableRequest <- map["charge_enable_request"]
        chargeLimitSocStd <- map["charge_limit_soc_std"]
        chargePortLatch <- (map["charge_port_latch"], EnumTransform())
        chargeCurrentRequest <- map["charge_current_request"]
        chargerPilotCurrent <- map ["charger_pilot_current"]
        chargeRate <- map["charge_rate"]
        chargeLimitSocMax <- map["charge_limit_soc_max"]
        chargeLimitSocMin <- map["charge_limit_soc_min"]
        usableBatteryLevel <- map["usable_battery_level"]
        maxRangeChargeCounter <- map["max_range_charge_counter"]
        chargerPower <- map["charger_power"]
        scheduledChargingPending <- map["scheduled_charging_pending"]
        managedChargingStartTime <- map["managed_charging_start_time"]
        chargeMilesAddedIdeal <- map["charge_miles_added_ideal"]
        managedChargingUserCanceled <- map["managed_charging_user_canceled"]
        chargeLimitSoc <- map["charge_limit_soc"]
        euVehicle <- map["eu_vehicle"]
        timeStamp <- map["timestamp"]
        
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

