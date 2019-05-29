//
//  SetChargeLimit.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Set the charge limit to a custom percentage.
public class SetChargeLimitOptions: JSONCodable {

    /// The percentage value Example: 75.
    public let limitValue: Double

    /// Set the charge limit to a custom percentage.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - limitValue: The percentage value Example: 75.
    public init(limitValue: Double) {
        self.limitValue = limitValue
    }

    private enum CodingKeys: String, CodingKey {
        case limitValue = "percent"
    }
}
