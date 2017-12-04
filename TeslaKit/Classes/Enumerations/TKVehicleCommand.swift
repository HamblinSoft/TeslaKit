//
//  TKVehicleCommand.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Commands that can be sent to the vehicle
public enum TKVehicleCommand: String, EnumCollection {

    /// Wakes up the car from the sleep state. Necessary to get some data from the car.
    case wake = "wake_up"

    /// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
//    case setValetMode = "set_valet_mode"

    /// Resets the PIN set for valet mode, if set.
    case resetValetPin = "reset_valet_pin"

    /// Opens the charge port. Does not close the charge port
    case openChargePort = "charge_port_door_open"

    /// Set the charge mode to standard (90% under the new percentage system introduced in 4.5).
    case setChargeLimitToStandard = "charge_standard"

    /// Set the charge mode to max range (100% under the new percentage system introduced in 4.5). Use sparingly!
    case setChargeLimitToMaxRange = "charge_max_range"

    /// Set the charge limit to a custom percentage.
//    case setChargeLimit = "set_charge_limit?percent=limit_value"

    /// Start charging. Must be plugged in, have power available, and not have reached your charge limit.
    case startCharging = "charge_start"

    /// Stop charging. Must already be charging.
    case stopCharging = "charge_stop"

    /// Flash the lights once.
    case flashLights = "flash_lights"

    /// Honk the horn once.
    case honkHorn = "honk_horn"

    /// Unlock the car's doors.
    case unlockDoors = "door_unlock"

    /// Lock the car's doors.
    case lockDoors = "door_lock"

    /// Set the temperature target for the HVAC system.
//    case setTemperature = "set_temps?driver_temp=driver_temp&passenger_temp=passenger_temp"

    /// Start the climate control system. Will cool or heat automatically, depending on set temperature.
    case startHVAC = "auto_conditioning_start"

    /// Stop the climate control system.
    case stopHVAC = "auto_conditioning_stop"

    /// Controls the car's panoramic roof, if installed.
//    case movePanoRoof = "sun_roof_control?state=state&percent=percent"

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
//    case remoteStart = "remote_start_drive?password=password"

    /// Open the trunk or frunk. Currently inoperable.
    case openTrunk = "trunk_open"

    /// Opens and closes the configured Homelink garage door of the vehicle. Keep in mind this is a toggle and the garage door state is unknown - a major limitation of Homelink
//    case triggerHomelink = "trigger_homelink"

    ///
//    case frontDefrosterOn = "front_defrost_on"

    ///
//    case frontDefrosterOff = "front_defrost_off"

    ///
//    case rearDefrosterOn = "rear_defrost_on"

    ///
//    case rearDefrosterOff = "rear_defrost_off"

    /// Returns a readable name for the command
    public var name: String { return self.rawValue.replacingOccurrences(of: "_", with: " ").capitalized }


    /// The vehicle command response object indicating whether the command was issued successfully
    public struct Response {

        /// Commmand result
        public var result: Bool = false

        /// Reason for the command result
        public var reason: String?

        /// Error
        public var error: String?

        /// Error Description
        public var errorDescription: String?

        ///
        public init() {}

        ///
        public init(result: Bool, reason: String) {
            self.result = result
            self.reason = reason
            self.error = reason
        }
    }
}

extension TKVehicleCommand.Response: TKMappable {
    public mutating func mapping(map: Map) {
        result <- map["response.result"]
        reason <- map["response.reason"]
        error <- map["error"]
        errorDescription <- map["error_description"]
    }
}
