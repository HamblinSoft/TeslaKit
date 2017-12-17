//
//  TKChargeState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Returns the state of charge in the battery.
public struct TKChargeState {

    ///
    public var chargingState: TKChargingState = TKChargingState.complete

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


    public init() {}
}

extension TKChargeState: TKDataRequestResponse {
    public mutating func mapping(map: Map) {
        chargingState <- (map["response.charging_state"], EnumTransform())
        chargeToMaxRange <- map["response.charge_to_max_range"]
        fastChargerPresent <- map["response.fast_charger_present"]
        batteryRange <- map["response.battery_range"]
        estBatteryRange <- map["response.est_battery_range"]
        idealBatteryRange <- map["response.ideal_battery_range"]
        batteryLevel <- map["response.battery_level"]
        timeToFullCharge <- map["response.time_to_full_charge"]
        chargePortDoorOpen <- map["response.charge_port_door_open"]
        
    }
}


//{
//    "response" : {
//        "fast_charger_type" : "<invalid>",
//        "timestamp" : 1511681566279,
//        "est_battery_range" : 188.87,
//        "user_charge_enable_request" : null,
//        "charge_energy_added" : 31.98,
//        "charge_current_request_max" : 48,
//        "charger_phases" : null,
//        "fast_charger_present" : false,
//        "battery_heater_on" : null,
//        "time_to_full_charge" : 0,
//        "motorized_charge_port" : true,
//        "trip_charging" : false,
//        "battery_range" : 216.77000000000001,
//        "charge_port_door_open" : false,
//        "charge_enable_request" : false,
//        "charge_limit_soc_std" : 90,
//        "charger_actual_current" : 0,
//        "charge_port_latch" : "Engaged",
//        "charge_current_request" : 48,
//        "charger_voltage" : 0,
//        "managed_charging_active" : false,
//        "charger_pilot_current" : 48,
//        "charge_rate" : 0,
//        "charge_limit_soc_max" : 100,
//        "charge_limit_soc_min" : 50,
//        "usable_battery_level" : 89,
//        "ideal_battery_range" : 271.41000000000003,
//        "max_range_charge_counter" : 2,
//        "scheduled_charging_start_time" : null,
//        "charger_power" : 0,
//        "scheduled_charging_pending" : false,
//        "not_enough_power_to_heat" : false,
//        "managed_charging_start_time" : null,
//        "charge_miles_added_rated" : 107.5,
//        "battery_level" : 89,
//        "charge_to_max_range" : true,
//        "charge_miles_added_ideal" : 134.5,
//        "managed_charging_user_canceled" : false,
//        "charge_limit_soc" : 97,
//        "eu_vehicle" : false,
//        "charging_state" : "Disconnected"
//    }
//}

