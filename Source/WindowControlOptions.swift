//
//  WindowControlOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 10/14/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation

///
public class WindowControlOptions: JSONCodable {

    ///
    public enum Command: String, Codable {
        case close
        case vent
    }

    ///
    public let command: Command

    ///
    public let latitude: Double

    ///
    public let longitude: Double

    ///
    public init(command: Command, latitude: Double, longitude: Double) {
        self.command = command
        self.latitude = latitude
        self.longitude = longitude
    }

    public convenience init(command: Command) {
        self.init(command: command, latitude: 0, longitude: 0)
    }

    ///
    public enum CodingKeys: String, CodingKey {
        case command = "command"
        case latitude = "lat"
        case longitude = "lon"
    }
}
