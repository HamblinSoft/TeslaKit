//
//  SetSpeedLimit.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/11/18.
//

import Foundation
import ObjectMapper

///
public struct SetSpeedLimit: Mappable {

    ///
    public var limitMPH: Double = 90

    ///
    public init() {}

    ///
    public init(limitMPH: Double) {
        self.limitMPH = limitMPH
    }
    
    ///
    public mutating func mapping(map: Map) {
        limitMPH <- map["limit_mph"]
    }
}
