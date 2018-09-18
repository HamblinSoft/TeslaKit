//
//  SpeedLimitMode.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/11/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct SpeedLimitMode: Mappable {

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
    public mutating func mapping(map: Map) {
        currentLimitMPH <- map["current_limit_mph"]
        pinCodeSet <- map["pin_code_set"]
        active <- map["active"]
        maxLimitMPH <- map["max_limit_mph"]
        minLimitMPH <- map["min_limit_mph"]
    }
}
