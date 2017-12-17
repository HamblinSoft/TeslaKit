//
//  TKResetValetPIN.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
public struct TKResetValetPIN {

    /// The id of the Vehicle. Example: 1.
    public var vehicleId: Int = 0

    /// Whether to enable or disable valet mode. Example: true.
    public var on: Bool = false

    /// (optional) A 4 digit PIN code to unlock the car. Example: 1234.
    public var password: Int? = nil

    ///
    public init() {}


    /// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - on: Whether to enable or disable valet mode. Example: true.
    ///   - password: (optional) A 4 digit PIN code to unlock the car. Example: 1234.
    public init(vehicleId: Int, on: Bool, password: Int?) {
        self.vehicleId = vehicleId
        self.on = on
        self.password = password
    }
}

extension TKResetValetPIN: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicle_id"]
        on <- map["on"]
        password <- map["password"]
    }
}
