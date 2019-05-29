//
//  SpeedLimitMode.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/11/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public class SpeedLimitMode: JSONDecodable {

    ///
    public var currentLimitMPH: Double = 90

    ///
    public var pinCodeSet: Bool = false

    ///
    public var active: Bool = false

    ///
    public var maxLimitMPH: Double = 90

    ///
    public var minLimitMPH: Double = 50

    ///
    public init() {}

    ///
    public init(currentLimitMPH: Double, pinCodeSet: Bool, active: Bool, maxLimitMPH: Double, minLimitMPH: Double) {
        self.currentLimitMPH = currentLimitMPH
        self.pinCodeSet = pinCodeSet
        self.active = active
        self.maxLimitMPH = maxLimitMPH
        self.minLimitMPH = minLimitMPH
    }

    ///
    private enum CodingKeys: String, CodingKey {
        case currentLimitMPH = "current_limit_mph"
        case pinCodeSet = "pin_code_set"
        case active = "active"
        case maxLimitMPH = "max_limit_mph"
        case minLimitMPH = "min_limit_mph"
    }
}
