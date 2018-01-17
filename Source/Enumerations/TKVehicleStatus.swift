//
//  TKVehicleStatus.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

/// Represents the different connection states the vehicle can be
public enum TKVehicleStatus: String {

    /// Vehicle is awake and connected to the network
    case online

    /// Vehicle is transition from offline to online state
    case waking

    /// Vehicle is dormant
    case asleep

    /// Returns a readable display name text for the status
    public var displayName: String { return self.rawValue.capitalized }
}
