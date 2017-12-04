//
//  TAVehicleCollection.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TAVehicleCollection {

    ///
    public var vehicles: [TAVehicle] = []

    ///
    public init() {}

    ///
    public init(vehicles: [TAVehicle]) {
        self.vehicles = vehicles
    }
}

extension TAVehicleCollection: TAMappable {
    public mutating func mapping(map: Map) {
        vehicles <- map["response"]
    }
}
