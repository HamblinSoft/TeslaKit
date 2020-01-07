//
//  WindowControlRequest.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 1/6/20.
//  Copyright © 2020 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct WindowControlRequest: TKMappable {

    ///
    public enum Command: String, Codable {
        case close
        case vent
    }

    ///
    public var command: Command = .close

    ///
    public var latitude: Double = 0

    ///
    public var longitude: Double = 0

    ///
    public init(command: Command, latitude: Double, longitude: Double) {
        self.command = command
        self.latitude = latitude
        self.longitude = longitude
    }

    public init(command: Command) {
        self.init(command: command, latitude: 0, longitude: 0)
    }

    public mutating func mapping(map: Map) {
        command <- map["command"]
        latitude <- map["lat"]
        longitude <- map["lon"]
    }
}
