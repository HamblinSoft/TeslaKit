//
//  TKSetTemperature.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Set the temperature target for the HVAC system.
public struct TKSetTemperature {

    /// The id of the Vehicle. Example: 1.
    public var vehicleId: Int = 0

    /// The desired temperature on the driver's side in celcius. Example: 23.7.
    public var driverTemp: Int = 0

    /// The desired temperature on the passenger's side in celcius. Example: 18.1.
    public var passengerTemp: Int = 0

    ///
    public init() {}


    /// Set the temperature target for the HVAC system.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - driverTemp: The desired temperature on the driver's side in celcius. Example: 23.7.
    ///   - passengerTemp: The desired temperature on the passenger's side in celcius. Example: 18.1.
    public init(vehicleId: Int, driverTemp: Int, passengerTemp: Int) {
        self.vehicleId = vehicleId
        self.driverTemp = driverTemp
        self.passengerTemp = passengerTemp
    }
}

extension TKSetTemperature: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicle_id"]
        driverTemp <- map["driver_temp"]
        passengerTemp <- map["passenger_temp"]
    }
}
