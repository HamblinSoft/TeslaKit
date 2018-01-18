//
//  TKChargingState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

/// 
public enum TKChargingState: String {

    /// The vehicle is not connected to a charger
    case disconnected = "Disconnected"

    /// The vehicle is connected to the charger, but charging has not started
    case stopped = "Stopped"

    /// The vehicle is connected to the charger and will begin charging
    case starting = "Starting"

    /// The vehicle is connected to the charger and is charging
    case charging = "Charging"

    /// The vehicle is connected to the charger and has completed charging
    case complete = "Complete"

    /// Returns a readable display name
    public var displayName: String {
        switch self {
        case .stopped: return "Connected"
        case .disconnected: return "Unplugged"
        default: return self.rawValue
        }
    }
}
