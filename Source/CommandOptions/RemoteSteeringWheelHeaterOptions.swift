//
//  RemoteSteeringWheelHeaterOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/27/18.
//

import Foundation

///
public class RemoteSteeringWheelHeaterOptions: JSONCodable {

    ///
    public let isOn: Bool

    ///
    public init(isOn: Bool) {
        self.isOn = isOn
    }

    ///
    private enum CodingKeys: String, CodingKey {
        case isOn = "on"
    }
}
