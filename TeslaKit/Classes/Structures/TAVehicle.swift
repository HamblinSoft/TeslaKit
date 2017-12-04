//
//  TAVehicle.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TAVehicle {

    /// The unique identifier of the vehicle
    public var id: Int = 0

    /// The unique identifier of the vehicle (use id)
    public var vehicleId: Int = 0

    /// The unique identifier of the user of the vehicle
    public var userId: Int = 0

    /// The display name of the vehicle
    public var displayName: String = ""

    /// The options of the vehicle
    public var options: [TAVehicleOption] = []

    /// The vehicle's vehicle identification number
    public var vin: VIN = VIN()

    /// The vehicle's current state
    public var status: TAVehicleStatus = TAVehicleStatus.asleep

    /// The vehicle's remote start configuration
    public var remoteStartEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(id: Int, vehicleId: Int, userId: Int, displayName: String, vin: String, status: TAVehicleStatus, remoteStartEnabled: Bool) {
        self.id = id
        self.vehicleId = vehicleId
        self.userId = userId
        self.displayName = displayName
        self.vin = VIN(vinString: vin)
        self.status = status
        self.remoteStartEnabled = remoteStartEnabled
    }
}

extension TAVehicle: TAMappable {
    public mutating func mapping(map: Map) {
        displayName <- map["display_name"]
        id <- map["id"]
        options <- (map["option_codes"], TAVehicleOptionTransform(separator: ","))
        userId <- map["user_id"]
        vehicleId <- map["vehicle_id"]
        vin <- (map["vin"], VINTransform())
        status <- (map["state"], EnumTransform())
        remoteStartEnabled <- map["remote_start_enabled"]
    }
}

