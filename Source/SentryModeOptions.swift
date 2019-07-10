//
//  SetSentryModeOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/28/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation

///
public class SentryModeOptions: JSONCodable {

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
