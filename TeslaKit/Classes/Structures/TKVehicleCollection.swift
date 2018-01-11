//
//  TKVehicleCollection.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Retrieve a list of your owned vehicles (includes vehicles not yet shipped!)
public struct TKVehicleCollection {

    ///
    public var vehicles: [TKVehicle] = []

    ///
    public init() {}

    ///
    public init(vehicles: [TKVehicle]) {
        self.vehicles = vehicles
    }

    ///
//    public struct Vehicle {
//
//        /// The unique identifier of the vehicle
//        public var id: String = ""
//
//        /// The unique identifier of the vehicle (use id)
//        public var vehicleId: Int = 0
//
//        /// The unique identifier of the user of the vehicle
//        public var userId: Int = 0
//
//        /// The display name of the vehicle
//        public var displayName: String = ""
//
//        /// The options of the vehicle
//        public var options: [TKVehicleOption] = []
//
//        /// The vehicle's vehicle identification number
//        public var vin: VIN?
//
//        /// The vehicle's current state
//        public var status: TKVehicleStatus = TKVehicleStatus.asleep
//
//        /// The vehicle's remote start configuration
//        public var remoteStartEnabled: Bool = false
//
//        ///
//        public var tokens: [String] = []
//
//        ///
//        public init() {}
//    }
}

extension TKVehicleCollection: TKMappable {
    public mutating func mapping(map: Map) {
        vehicles <- map["response"]
    }
}

//extension TKVehicleCollection.Vehicle: TKMappable {
//    public mutating func mapping(map: Map) {
//        displayName <- map["display_name"]
//        id <- map["id_s"]
//        options <- (map["option_codes"], TKVehicleOptionTransform(separator: ","))
//        userId <- map["user_id"]
//        vehicleId <- map["vehicle_id"]
//        vin <- (map["vin"], VINTransform())
//        status <- (map["state"], EnumTransform())
//        remoteStartEnabled <- map["remote_start_enabled"]
//        tokens <- map["tokens"]
//    }
//}

