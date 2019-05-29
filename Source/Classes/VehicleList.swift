//
//  VehicleList.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Retrieve a list of your owned vehicles (includes vehicles not yet shipped!)
public class VehicleList: JSONDecodable {

    ///
    public var vehicles: [Vehicle]

    ///
    public init(vehicles: [Vehicle]) {
        self.vehicles = vehicles
    }

    private enum CodingKeys: String, CodingKey {
        case vehicles = "response"
    }
}
