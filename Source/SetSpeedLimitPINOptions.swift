//
//  SetSpeedLimitPINOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/13/18.
//

import Foundation

///
public class SetSpeedLimitPINOptions: JSONCodable {

    /// 4 digit pin
    public let pin: String

    ///
    public init(pin: String) {
        self.pin = pin
    }

    ///
    private enum CodingKeys: String, CodingKey {
        case pin
    }
}
