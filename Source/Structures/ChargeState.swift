//
//  ChargeState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response object containing information about the charge state of the vehicle
public struct ChargeState {

    ///
    public var chargingState: ChargingState = ChargingState.stopped

    ///
    public var chargeToMaxRange: Bool = false

    ///
    public var fastChargerPresent: Bool = false

    ///
    public var batteryRange: Double = 0

    ///
    public var estBatteryRange: Double = 0

    ///
    public var idealBatteryRange: Double = 0

    /// Percentage
    public var batteryLevel: Double = 0.0

    ///
    public var timeToFullCharge: Double = 0.0

    ///
    public var chargePortDoorOpen: Bool = false

    ///
    public var fastChargerType: String? = nil
    
    ///
    public var userChargeEnableRequest: Int = 0

    /// The amount of kH added
    public var chargeEnergyAdded: Double = 0

    /// The maximum charge current that can be requested
    public var chargeCurrentRequestMax: Int = 0

    ///
    public var chargerPhases: Int = 0
    
    ///
    public var batteryHeaterOn: Int = 0
    
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
    public var chargePortLatch: ChargePortLatchState = ChargePortLatchState.unknown
    
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
    public var scheduledChargingStartTime: Date? = nil

    ///
    public var chargerPower: Int = 0
    
    ///
    public var scheduledChargingPending: Bool = false

    ///
    public var notEnoughPowerToHeat: Bool = false
    
    ///
    public var managedChargingStartTime: TimeInterval? = nil

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

    ///
    public var fastChargerBrand: String? = nil

    ///
    public var connChargeCable: String? = nil

    /// Returns whether the vehicle is connected to a charger or not
    public var isChargerConnected: Bool { return self.chargingState != .disconnected }

    /// Returns whether the vehicle is improperly connected to a charger
    public var isChargerImproperlyConnected: Bool { return self.isChargerConnected && self.chargePortLatch == .disengaged }

    /// Returns whether the vehicle is charging or will begin charging
    public var isCharging: Bool { return self.chargingState == .starting || self.chargingState == .charging }

    ///
    public init() {}
}

extension ChargeState: DataResponse {
    public mutating func mapping(map: Map) {
        batteryHeaterOn <- map["battery_heater_on"]
        batteryLevel <- map["battery_level"]
        batteryRange <- map["battery_range"]
        chargeCurrentRequest <- map["charge_current_request"]
        chargeCurrentRequestMax <- map["charge_current_request_max"]
        chargeEnableRequest <- map["charge_enable_request"]
        chargeEnergyAdded <- map["charge_energy_added"]
        chargeLimitSoc <- map["charge_limit_soc"]
        chargeLimitSocMax <- map["charge_limit_soc_max"]
        chargeLimitSocMin <- map["charge_limit_soc_min"]
        chargeLimitSocStd <- map["charge_limit_soc_std"]
        chargeMilesAddedIdeal <- map["charge_miles_added_ideal"]
        chargeMilesAddedRated <- map["charge_miles_added_rated"]
        chargePortDoorOpen <- map["charge_port_door_open"]
        chargePortLatch <- (map["charge_port_latch"], EnumTransform())
        chargerActualCurrent <- map["charger_actual_current"]
        chargeRate <- map["charge_rate"]
        chargingState <- (map["charging_state"], EnumTransform())
        chargerPhases <- map["charger_phases"]
        chargerPilotCurrent <- map ["charger_pilot_current"]
        chargerPower <- map["charger_power"]
        chargerVoltage <- map["charger_voltage"]
        chargeToMaxRange <- map["charge_to_max_range"]
        estBatteryRange <- map["est_battery_range"]
        euVehicle <- map["eu_vehicle"]
        fastChargerPresent <- map["fast_charger_present"]
        fastChargerType <- map["fast_charger_type"]
        idealBatteryRange <- map["ideal_battery_range"]
        managedChargingActive <- map["managed_charging_active"]
        managedChargingStartTime <- map["managed_charging_start_time"]
        managedChargingUserCanceled <- map["managed_charging_user_canceled"]
        maxRangeChargeCounter <- map["max_range_charge_counter"]
        motorizedChargePort <- map["motorized_charge_port"]
        notEnoughPowerToHeat <- map["not_enough_power_to_heat"]
        scheduledChargingPending <- map["scheduled_charging_pending"]
        scheduledChargingStartTime <- (map["scheduled_charging_start_time"], DateTransform())
        timeStamp <- map["timestamp"]
        timeToFullCharge <- map["time_to_full_charge"]
        tripCharging <- map["trip_charging"]
        usableBatteryLevel <- map["usable_battery_level"]
        userChargeEnableRequest <- map["user_charge_enable_request"]
        fastChargerBrand <- map["fast_charger_brand"]
        connChargeCable <- map["conn_charge_cable"]
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

