//
//  TKDataRequest.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

///
public enum TKDataRequest: String, EnumCollection {

    // MARK: - State and Settings
    // These resources are read-only and determine the state of the vehicle's various sub-systems.

    /// Determines if mobile access to the vehicle is enabled.
    case mobileAccess = "mobile_enabled"

    /// Returns the state of charge in the battery.
    case chargeState = "charge_state"

    /// Returns the current temperature and climate control state.
    case climateSettings = "climate_state"

    /// Returns the driving and position state of the vehicle.
    case drivingPosition = "drive_state"

    /// Returns various information about the GUI settings of the car, such as unit format and range display.
    case guiSettings = "gui_settings"

    /// Returns the vehicle's physical state, such as which doors are open.
    case vehicleState = "vehicle_state"

}
