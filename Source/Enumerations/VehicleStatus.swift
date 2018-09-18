//
//  VehicleStatus.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Represents the different connection states the vehicle can be
public enum VehicleStatus: String, CustomStringConvertible {

    /// Vehicle is awake and connected to the network
    case online

    ///
    case offline

    /// Vehicle is dormant
    case asleep

    /// Returns a readable display name text for the status
    public var description: String { return self.rawValue.capitalized }
}
