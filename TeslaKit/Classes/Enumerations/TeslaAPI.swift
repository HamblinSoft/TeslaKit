//
//  TeslaAPI.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

///
public typealias TKVehicleCommandCompletion = (TKVehicleCommandResponse) -> Void

///
public enum TeslaAPI: String, EnumCollection {

    ///
    public static let baseURL: URL = URL(string: "https://owner-api.teslamotors.com")!

    ///
    public static let apiVersion: Int = 1

    ///
    public static let apiBaseURL: URL = baseURL.appendingPathComponent("api/\(TeslaAPI.apiVersion)")

    /// Tesla API owner api client id
    public static let ownerApiClientId: String = "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e"

    /// Tesla API owner api client secret
    public static let ownerApiClientSecret: String = "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220"




    /// Performs the login. Takes in an plain text email and password, matching the owner's login information for https://my.teslamotors.com/user/login. Returns a access_token which is passed along as a header with all future requests to authenticate the user.
    case accessToken = "oauth/token"

    // MARK: - Vehicles

    // A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.

    /// Retrieve a list of your owned vehicles (includes vehicles not yet shipped!)
    case vehicles = "vehicles"


    public var url: URL {
        switch self {
        case .accessToken: return TeslaAPI.baseURL.appendingPathComponent(self.rawValue)
        default: return TeslaAPI.apiBaseURL.appendingPathComponent(self.rawValue)
        }
    }



    // MARK: - State and Settings

    /// These resources are read-only and determine the state of the vehicle's various sub-systems.
    public enum DataRequest: String {

        /// Determines if mobile access to the vehicle is enabled.
        case mobileAccess = "mobile_enabled"

        /// Returns the state of charge in the battery.
        case chargeState = "charge_state"

        /// Returns the current temperature and climate control state.
        case climateState = "climate_state"

        /// Returns the driving and position state of the vehicle.
        case driveState = "drive_state"

        /// Returns various information about the GUI settings of the car, such as unit format and range display.
        case guiSettings = "gui_settings"

        /// Returns the vehicle's physical state, such as which doors are open.
        case vehicleState = "vehicle_state"

        ///
        case data = "data"

        ///
        public func url(vehicleId: Int) -> URL {
            switch self {
            case .mobileAccess: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/\(self.rawValue)")
            case .data: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/\(self.rawValue)")
            default: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/data_request/\(self.rawValue)")
            }
        }
    }




    // MARK: - Vehicle Commands

    ///
    public enum Command: String, EnumCollection {

        /// Wakes up the car from the sleep state. Necessary to get some data from the car.
        case wake = "wake_up"

        /// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
        case setValetMode = "set_valet_mode"

        /// Resets the PIN set for valet mode, if set.
        case resetValetPin = "reset_valet_pin"

        /// Opens the charge port. Does not close the charge port
        case openChargePort = "charge_port_door_open"

        /// Set the charge mode to standard (90% under the new percentage system introduced in 4.5).
        case setChargeLimitToStandard = "charge_standard"

        /// Set the charge mode to max range (100% under the new percentage system introduced in 4.5). Use sparingly!
        case setChargeLimitToMaxRange = "charge_max_range"

        /// Set the charge limit to a custom percentage.
        case setChargeLimit = "set_charge_limit"

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
        case setTemperature = "set_temps"

        /// Start the climate control system. Will cool or heat automatically, depending on set temperature.
        case startHVAC = "auto_conditioning_start"

        /// Stop the climate control system.
        case stopHVAC = "auto_conditioning_stop"

        /// Controls the car's panoramic roof, if installed.
        case movePanoRoof = "sun_roof_control"

        /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
        case remoteStart = "remote_start_drive"

        /// Open the trunk or frunk. Currently inoperable.
        //    case openTrunk = "trunk_open"

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

        /// Returns the API URL provided a vehicleId for the command
        public func url(vehicleId: Int) -> URL {
            return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/command/\(self.rawValue)")
        }
    }



    /// Commands that can be quickliy sent
    public static let quickCommands: [Command] = [.unlockDoors, .lockDoors, .flashLights, .honkHorn, .startHVAC, .stopHVAC, .openChargePort, .setChargeLimitToStandard, .setChargeLimitToMaxRange, .startCharging, .stopCharging]
}
