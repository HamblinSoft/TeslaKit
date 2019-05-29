//
//  SetTemperatureOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Set the temperature target for the HVAC system.
public class SetTemperatureOptions: JSONCodable {

    /// The desired temperature on the driver's side in celcius. Example: 23.7.
    public let driverTemp: Double

    /// The desired temperature on the passenger's side in celcius. Example: 18.1.
    public let passengerTemp: Double

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

    private enum CodingKeys: String, CodingKey {
        case driverTemp = "driver_temp"
        case passengerTemp = "passenger_temp"
    }
}
