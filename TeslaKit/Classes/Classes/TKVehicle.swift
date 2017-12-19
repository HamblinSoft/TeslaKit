//
//  TKVehicle.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Object representing a Tesla vehicle
public class TKVehicle {

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
    public var mobileAccess: Bool = true

    // Convenience

    ///
    public var chargeState: TKChargeState = TKChargeState()

    ///
    public var climateState: TKClimateState = TKClimateState()

    ///
    public var driveState: TKDriveState = TKDriveState()

    ///
    public var guiSettings: TKGUISettings = TKGUISettings()

    ///
    public var vehicleState: TKVehicleState = TKVehicleState()



    ///
    public required init() {}

    ///
    public init(id: Int, vehicleId: Int, userId: Int, displayName: String, vin: String, status: TKVehicleStatus, remoteStartEnabled: Bool) {
        self.id = id
        self.vehicleId = vehicleId
        self.userId = userId
        self.displayName = displayName
        self.vin = VIN(vinString: vin)
        self.status = status
        self.remoteStartEnabled = remoteStartEnabled
    }
}

extension TKVehicle: TKMappable {
    public func mapping(map: Map) {
        displayName <- map["display_name"]
        id <- map["id"]
        options <- (map["option_codes"], TKVehicleOptionTransform(separator: ","))
        userId <- map["user_id"]
        vehicleId <- map["vehicle_id"]
        vin <- (map["vin"], VINTransform())
        status <- (map["state"], EnumTransform())
        remoteStartEnabled <- map["remote_start_enabled"]
        tokens <- map["tokens"]
        chargeState <- map["charge_state"]
        climateState <- map["climate_state"]
        guiSettings <- map["gui_settings"]
        driveState <- map["drive_state"]
        vehicleState <- map["vehicle_state"]
    }
}

