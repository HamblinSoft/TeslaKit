//
//  RemoteSeatHeaterRequest.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/27/18.
//

import Foundation
import ObjectMapper

///
public struct RemoteSeatHeaterRequest: TKMappable {

    ///
    public var heater: SeatHeater?

    ///
    public var level: Int = 1

    ///
    public init(heater: SeatHeater, level: Int) {
        self.heater = heater
        self.level = level
    }

    ///
    public mutating func mapping(map: Map) {
        heater <- (map["heater"], EnumTransform())
        level <- map["level"]
    }
}
