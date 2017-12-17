//
//  TKRemoteStart.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
public struct TKRemoteStart {

    /// The id of the Vehicle. Example: 1.
    public var vehicleId: Int = 0

    /// The password to the authenticated my.teslamotors.com account.
    public var password: String = ""

    ///
    public init() {}

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - password: The password to the authenticated my.teslamotors.com account.
    public init(vehicleId: Int, password: String) {
        self.vehicleId = vehicleId
        self.password = password
    }
}

extension TKRemoteStart: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicle_id"]
        password <- map["password"]
    }
}
