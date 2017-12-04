//
//  TAVehicleStatus.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

/// Represents the different connection states the vehicle can be
public enum TAVehicleStatus: String {

    /// Vehicle is awake and connected to the network
    case online

    /// Vehicle is transition from offline to online state
    case waking

    /// Vehicle is dormant
    case asleep
}
