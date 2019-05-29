//
//  MovePanoRoofOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Controls the car's panoramic roof, if installed.
public class MovePanoRoofOptions: JSONCodable {

    /// The desired state of the panoramic roof. The approximate percent open values for each state are open = 100%, close = 0%, comfort = 80%, and vent = ~15% Example: open. Possible values:  open , close , comfort , vent , move .
    public let state: PanoRoofState

    /// The percentage to move the roof to. Example: 50.
    public let percent: Int?

    /// Controls the car's panoramic roof, if installed.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - state: The desired state of the panoramic roof. The approximate percent open values for each state are open = 100%, close = 0%, comfort = 80%, and vent = ~15% Example: open. Possible values:  open , close , comfort , vent , move .
    ///   - percent: The percentage to move the roof to. Example: 50.
    public init(state: PanoRoofState, percent: Int?) {
        self.state = state
        self.percent = percent
    }

    private enum CodingKeys: String, CodingKey {
        case state = "state"
        case percent = "percent"
    }
}
