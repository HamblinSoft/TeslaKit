//
//  TKSetChargeLimit.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Set the charge limit to a custom percentage.
public struct TKSetChargeLimit {

    /// The id of the Vehicle. Example: 1.
    public var vehicleId: Int = 0

    /// The percentage value Example: 75.
    public var limitValue: Int = 0

    ///
    public init() {}


    /// Set the charge limit to a custom percentage.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - limitValue: The percentage value Example: 75.
    public init(vehicleId: Int, limitValue: Int) {
        self.vehicleId = vehicleId
        self.limitValue = limitValue
    }
}

extension TKSetChargeLimit: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicle_id"]
        limitValue <- map["limit_value"]
    }
}
