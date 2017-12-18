//
//  TKVehicleData.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleData {

    /// The unique identifier of the vehicle
    public var id: Int = 0

    /// The unique identifier of the vehicle (use id)
    public var vehicleId: Int = 0

    /// The unique identifier of the user of the vehicle
    public var userId: Int = 0

    /// The display name of the vehicle
    public var displayName: String = ""

    /// The options of the vehicle
    public var options: [TKVehicleOption] = []

    /// The vehicle's vehicle identification number
    public var vin: VIN?

    /// The vehicle's current state
    public var status: TKVehicleStatus = TKVehicleStatus.asleep

    /// The vehicle's remote start configuration
    public var remoteStartEnabled: Bool = false

    ///
    public var tokens: [String] = []

    ///
    public var chargeState: TKChargeState = TKChargeState()

    ///
    public var climateSettings: TKClimateSettings = TKClimateSettings()

    ///
    public var guiSettings: TKGUISettings = TKGUISettings()

    ///
    public var drivePosition: TKDrivingPosition = TKDrivingPosition()

    ///
    public var vehicleState: TKVehicleState = TKVehicleState()

    ///
    public init() {}
}

extension TKVehicleData: TKDataResponse {
    public mutating func mapping(map: Map) {
        displayName <- map["response.display_name"]
        id <- map["response.id"]
        options <- (map["response.option_codes"], TKVehicleOptionTransform(separator: ","))
        userId <- map["response.user_id"]
        vehicleId <- map["response.vehicle_id"]
        vin <- (map["response.vin"], VINTransform())
        status <- (map["response.state"], EnumTransform())
        remoteStartEnabled <- map["response.remote_start_enabled"]
        tokens <- map["response.tokens"]
        chargeState <- map["response.charge_state"]
        climateSettings <- map["response.climate_state"]
        guiSettings <- map["response.gui_settings"]
        drivePosition <- map["response.drive_state"]
        vehicleState <- map["response.vehicle_state"]
    }
}
