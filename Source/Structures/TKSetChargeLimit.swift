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

    /// The percentage value Example: 75.
    public var limitValue: Double = 0

    ///
    public init() {}


    /// Set the charge limit to a custom percentage.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - limitValue: The percentage value Example: 75.
    public init(limitValue: Double) {
        self.limitValue = limitValue
    }
}

extension TKSetChargeLimit: TKMappable {
    public mutating func mapping(map: Map) {
        limitValue <- map["percent"]
    }
}
