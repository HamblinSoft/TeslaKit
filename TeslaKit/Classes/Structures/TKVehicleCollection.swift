//
//  TKVehicleCollection.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleCollection {

    ///
    public var vehicles: [TKVehicle] = []

    ///
    public init() {}

    ///
    public init(vehicles: [TKVehicle]) {
        self.vehicles = vehicles
    }
}

extension TKVehicleCollection: TKMappable {
    public mutating func mapping(map: Map) {
        vehicles <- map["response"]
    }
}
