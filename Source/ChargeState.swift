//
//  ChargeState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response object containing information about the charge state of the vehicle
public final class ChargeState: JSONDecodable {

    ///
    public var chargingStatus: ChargingStatus = ChargingStatus.stopped

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
    public var chargerPhases: Int?
    
    ///
    public var batteryHeaterOn: Bool = false
    
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
    public var chargeRate: Double = 0
    
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
    public var notEnoughPowerToHeat: Bool? = false
    
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
    public var timeStamp: TimeInterval = 0

    ///
    public var fastChargerBrand: String? = nil

    ///
    public var connChargeCable: String? = nil

    ///
    public var chargePortColdWeatherMode: Bool = false

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.chargingStatus = try decoder.decodeIfPresent(CodingKeys.chargingStatus) ?? .stopped
        self.chargeToMaxRange = try decoder.decodeIfPresent(CodingKeys.chargeToMaxRange) ?? false
        self.fastChargerPresent = try decoder.decodeIfPresent(CodingKeys.fastChargerPresent) ?? false
        self.batteryRange = try decoder.decodeIfPresent(CodingKeys.batteryRange) ?? 0
        self.estBatteryRange = try decoder.decodeIfPresent(CodingKeys.estBatteryRange) ?? 0
        self.idealBatteryRange = try decoder.decodeIfPresent(CodingKeys.idealBatteryRange) ?? 0
        self.batteryLevel = try decoder.decodeIfPresent(CodingKeys.batteryLevel) ?? 0
        self.timeToFullCharge = try decoder.decodeIfPresent(CodingKeys.timeToFullCharge) ?? 0
        self.chargePortDoorOpen = try decoder.decodeIfPresent(CodingKeys.chargePortDoorOpen) ?? false
        self.fastChargerType = try decoder.decodeIfPresent(CodingKeys.fastChargerType)
        self.userChargeEnableRequest = try decoder.decodeIfPresent(CodingKeys.userChargeEnableRequest) ?? 0
        self.chargeEnergyAdded = try decoder.decodeIfPresent(CodingKeys.chargeEnergyAdded) ?? 0
        self.chargeCurrentRequestMax = try decoder.decodeIfPresent(CodingKeys.chargeCurrentRequestMax) ?? 0
        self.chargerPhases = try decoder.decodeIfPresent(CodingKeys.chargerPhases)
        self.batteryHeaterOn = try decoder.decodeIfPresent(CodingKeys.batteryHeaterOn) ?? false
        self.tripCharging = try decoder.decodeIfPresent(CodingKeys.tripCharging) ?? false
        self.chargeEnableRequest = try decoder.decodeIfPresent(CodingKeys.chargeEnableRequest) ?? false
        self.chargeLimitSocStd = try decoder.decodeIfPresent(CodingKeys.chargeLimitSocStd) ?? 0
        self.chargerActualCurrent = try decoder.decodeIfPresent(CodingKeys.chargerActualCurrent) ?? 0
        self.chargePortLatch = try decoder.decodeIfPresent(CodingKeys.chargePortLatch) ?? .unknown
        self.chargeCurrentRequest = try decoder.decodeIfPresent(CodingKeys.chargeCurrentRequest) ?? 0
        self.chargerVoltage = try decoder.decodeIfPresent(CodingKeys.chargerVoltage) ?? 0
        self.managedChargingActive = try decoder.decodeIfPresent(CodingKeys.managedChargingActive) ?? false
        self.chargerPilotCurrent = try decoder.decodeIfPresent(CodingKeys.chargerPilotCurrent) ?? 0
        self.chargeRate = try decoder.decodeIfPresent(CodingKeys.chargeRate) ?? 0
        self.chargeLimitSocMax = try decoder.decodeIfPresent(CodingKeys.chargeLimitSocMax) ?? 0
        self.chargeLimitSocMin = try decoder.decodeIfPresent(CodingKeys.chargeLimitSocMin) ?? 0
        self.usableBatteryLevel = try decoder.decodeIfPresent(CodingKeys.usableBatteryLevel) ?? 0
        self.maxRangeChargeCounter = try decoder.decodeIfPresent(CodingKeys.maxRangeChargeCounter) ?? 0
        self.scheduledChargingStartTime = try decoder.decodeIfPresent(CodingKeys.scheduledChargingStartTime)
        self.chargerPower = try decoder.decodeIfPresent(CodingKeys.chargerPower) ?? 0
        self.scheduledChargingPending = try decoder.decodeIfPresent(CodingKeys.scheduledChargingPending) ?? false
        self.notEnoughPowerToHeat = try decoder.decodeIfPresent(CodingKeys.notEnoughPowerToHeat)
        self.managedChargingStartTime = try decoder.decodeIfPresent(CodingKeys.managedChargingStartTime)
        self.chargeMilesAddedRated = try decoder.decodeIfPresent(CodingKeys.chargeMilesAddedRated) ?? 0
        self.chargeMilesAddedIdeal = try decoder.decodeIfPresent(CodingKeys.chargeMilesAddedIdeal) ?? 0
        self.managedChargingUserCanceled = try decoder.decodeIfPresent(CodingKeys.managedChargingUserCanceled) ?? false
        self.chargeLimitSoc = try decoder.decodeIfPresent(CodingKeys.chargeLimitSoc) ?? 0
        self.timeStamp = try decoder.decodeIfPresent(CodingKeys.timeStamp) ?? 0
        self.fastChargerBrand = try decoder.decodeIfPresent(CodingKeys.fastChargerBrand)
        self.connChargeCable = try decoder.decodeIfPresent(CodingKeys.connChargeCable)
        self.chargePortColdWeatherMode = try decoder.decodeIfPresent(CodingKeys.chargePortColdWeatherMode) ?? false

    }

    /// Returns whether the vehicle is connected to a charger or not
    public var isChargerConnected: Bool { return chargingStatus != .disconnected }

    /// Returns whether the vehicle is improperly connected to a charger
    public var isChargerImproperlyConnected: Bool { return self.isChargerConnected && self.chargePortLatch == .disengaged }

    /// Returns whether the vehicle is charging or will begin charging
    public var isCharging: Bool { return chargingStatus == .starting || chargingStatus == .charging }

    private enum CodingKeys: String, CodingKey {
        case batteryHeaterOn = "battery_heater_on"
        case batteryLevel = "battery_level"
        case batteryRange = "battery_range"
        case chargeCurrentRequest = "charge_current_request"
        case chargeCurrentRequestMax = "charge_current_request_max"
        case chargeEnableRequest = "charge_enable_request"
        case chargeEnergyAdded = "charge_energy_added"
        case chargeLimitSoc = "charge_limit_soc"
        case chargeLimitSocMax = "charge_limit_soc_max"
        case chargeLimitSocMin = "charge_limit_soc_min"
        case chargeLimitSocStd = "charge_limit_soc_std"
        case chargeMilesAddedIdeal = "charge_miles_added_ideal"
        case chargeMilesAddedRated = "charge_miles_added_rated"
        case chargePortDoorOpen = "charge_port_door_open"
        case chargePortLatch = "charge_port_latch"
        case chargerActualCurrent = "charger_actual_current"
        case chargeRate = "charge_rate"
        case chargingStatus = "charging_state"
        case chargerPhases = "charger_phases"
        case chargerPilotCurrent = "charger_pilot_current"
        case chargerPower = "charger_power"
        case chargerVoltage = "charger_voltage"
        case chargeToMaxRange = "charge_to_max_range"
        case estBatteryRange = "est_battery_range"
        case fastChargerPresent = "fast_charger_present"
        case fastChargerType = "fast_charger_type"
        case idealBatteryRange = "ideal_battery_range"
        case managedChargingActive = "managed_charging_active"
        case managedChargingStartTime = "managed_charging_start_time"
        case managedChargingUserCanceled = "managed_charging_user_canceled"
        case maxRangeChargeCounter = "max_range_charge_counter"
        case notEnoughPowerToHeat = "not_enough_power_to_heat"
        case scheduledChargingPending = "scheduled_charging_pending"
        case scheduledChargingStartTime = "scheduled_charging_start_time"
        case timeStamp = "timestamp"
        case timeToFullCharge = "time_to_full_charge"
        case tripCharging = "trip_charging"
        case usableBatteryLevel = "usable_battery_level"
        case userChargeEnableRequest = "user_charge_enable_request"
        case fastChargerBrand = "fast_charger_brand"
        case connChargeCable = "conn_charge_cable"
        case chargePortColdWeatherMode = "charge_port_cold_weather_mode"
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
