//
//  SpeedLimitSetPIN.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/13/18.
//

import Foundation
import ObjectMapper

///
public struct SpeedLimitSetPIN: Mappable {

    /// 4 digit pin
    public var pin: String = ""

    ///
    public init() {}

    ///
    public init(pin: String) {
        self.pin = pin
    }

    ///
    public mutating func mapping(map: Map) {
        pin <- map["pin"]
    }
}
