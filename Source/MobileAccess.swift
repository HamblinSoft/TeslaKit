//
//  MobileAccess.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Determines if mobile access to the vehicle is enabled.
public class MobileAccess: JSONDecodable {

    ///
    public var isEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(isEnabled: Bool) {
        self.isEnabled = isEnabled
    }

    private enum CodingKeys: String, CodingKey {
        case isEnabled = "response"
    }
}
