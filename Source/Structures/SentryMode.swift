//
//  SentryMode.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/28/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct SentryMode: ImmutableMappable {

    ///
    public let isOn: Bool

    ///
    public init(isOn: Bool) {
        self.isOn = isOn
    }

    ///
    public init(map: Map) throws {
        isOn = try map.value("on")
    }

    ///
    public func mapping(map: Map) {
        isOn >>> map["on"]
    }
}
