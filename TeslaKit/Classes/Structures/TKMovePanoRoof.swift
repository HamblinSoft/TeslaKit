//
//  TKMovePanoRoof.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Controls the car's panoramic roof, if installed.
public struct TKMovePanoRoof {

    /// The id of the Vehicle. Example: 1.
    public var vehicleId: Int = 0

    /// The desired state of the panoramic roof. The approximate percent open values for each state are open = 100%, close = 0%, comfort = 80%, and vent = ~15% Example: open. Possible values:  open , close , comfort , vent , move .
    public var state: TKPanoRoofState = TKPanoRoofState.closed

    /// The percentage to move the roof to. Example: 50.
    public var percent: Int? = nil

    ///
    public init() {}


    /// Controls the car's panoramic roof, if installed.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - state: The desired state of the panoramic roof. The approximate percent open values for each state are open = 100%, close = 0%, comfort = 80%, and vent = ~15% Example: open. Possible values:  open , close , comfort , vent , move .
    ///   - percent: The percentage to move the roof to. Example: 50.
    public init(vehicleId: Int, state: TKPanoRoofState, percent: Int?) {
        self.vehicleId = vehicleId
        self.state = state
        self.percent = percent
    }
}

extension TKMovePanoRoof: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicle_id"]
        state <- map["state"]
        percent <- map["percent"]
    }
}
