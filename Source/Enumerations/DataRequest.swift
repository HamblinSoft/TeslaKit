//
//  DataRequest.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 1/10/18.
//

import Foundation

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
}
