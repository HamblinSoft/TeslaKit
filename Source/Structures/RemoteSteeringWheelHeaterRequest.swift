//
//  RemoteSteeringWheelHeaterRequest.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/27/18.
//

import Foundation
import ObjectMapper

///
public struct RemoteSteeringWheelHeaterRequest: TKMappable {

    ///
    public var level: Int = 0

    ///
    public init(level: Int) {
        self.level = level
    }

    ///
    public mutating func mapping(map: Map) {
        level <- map["on"]
    }
}
