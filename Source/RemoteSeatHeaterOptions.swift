//
//  RemoteSeatHeaterOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/27/18.
//

import Foundation

///
public class RemoteSeatHeaterOptions: JSONCodable {

    ///
    public let heater: SeatPosition?

    ///
    public let level: Int

    ///
    public init(heater: SeatPosition, level: Int) {
        self.heater = heater
        self.level = level
    }

    ///
    private enum CodingKeys: String, CodingKey {
        case heater = "heater"
        case level = "level"
    }
}
