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

    ///
    case disconnected = "Disconnected"

    ///
    case stopped = "Stopped"

    ///
    case starting = "Starting"

    ///
    case charging = "Charging"

    ///
    case complete = "Complete"

    ///
    public var displayName: String { return self.rawValue }
}
