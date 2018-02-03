//
//  TKVehicle.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicle {

    /// The unique identifier of the vehicle
    public var id: String = ""

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
    public var climateState: TKClimateState = TKClimateState()

    ///
    public var guiSettings: TKGUISettings = TKGUISettings()

    ///
    public var driveState: TKDriveState = TKDriveState()

    ///
    public var vehicleState: TKVehicleState = TKVehicleState()

    ///
    public var vehicleConfig: TKVehicleConfig = TKVehicleConfig()

    ///
    public init() {}

    ///
    public var timestamp: TimeInterval { return self.climateState.timestamp }
}

extension TKVehicle: TKDataResponse {
    public mutating func mapping(map: Map) {
        let isVehicleData: Bool = !(map.JSON["id_s"] is String)
        if isVehicleData {
            displayName <- map["response.display_name"]
            id <- map["response.id_s"]
            options <- (map["response.option_codes"], TKVehicleOptionTransform(separator: ","))
            userId <- map["response.user_id"]
            vehicleId <- map["response.vehicle_id"]
            vin <- (map["response.vin"], VINTransform())
            status <- (map["response.state"], EnumTransform())
            remoteStartEnabled <- map["response.remote_start_enabled"]
            tokens <- map["response.tokens"]
            chargeState <- map["response.charge_state"]
            climateState <- map["response.climate_state"]
            guiSettings <- map["response.gui_settings"]
            driveState <- map["response.drive_state"]
            vehicleState <- map["response.vehicle_state"]
            vehicleConfig <- map["response.vehicle_config"]
        } else {
            displayName <- map["display_name"]
            id <- map["id_s"]
            options <- (map["option_codes"], TKVehicleOptionTransform(separator: ","))
            userId <- map["user_id"]
            vehicleId <- map["vehicle_id"]
            vin <- (map["vin"], VINTransform())
            status <- (map["state"], EnumTransform())
            remoteStartEnabled <- map["remote_start_enabled"]
            tokens <- map["tokens"]
        }
    }
}

extension TKVehicle: Equatable {
    public static func == (lhs: TKVehicle, rhs: TKVehicle) -> Bool {
        return lhs.chargeState.batteryLevel == rhs.chargeState.batteryLevel
            && lhs.chargeState.batteryRange == rhs.chargeState.batteryRange
    }
}

