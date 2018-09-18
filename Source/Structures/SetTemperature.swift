//
//  SetTemperature.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Set the temperature target for the HVAC system.
public struct SetTemperature {

    /// The desired temperature on the driver's side in celcius. Example: 23.7.
    public var driverTemp: Double = 0

    /// The desired temperature on the passenger's side in celcius. Example: 18.1.
    public var passengerTemp: Double = 0

    ///
    public init() {}


    /// Set the temperature target for the HVAC system.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - driverTemp: The desired temperature on the driver's side in celcius. Example: 23.7.
    ///   - passengerTemp: The desired temperature on the passenger's side in celcius. Example: 18.1.
    public init(driverTemp: Double, passengerTemp: Double) {
        self.driverTemp = driverTemp
        self.passengerTemp = passengerTemp
    }
}

extension SetTemperature: Mappable {
    public mutating func mapping(map: Map) {
        driverTemp <- map["driver_temp"]
        passengerTemp <- map["passenger_temp"]
    }
}
