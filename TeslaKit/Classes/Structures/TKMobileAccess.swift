//
//  TKMobileAccess.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Determines if mobile access to the vehicle is enabled.
public struct TKMobileAccess {

    ///
    public var response: Bool = false

    ///
    public init() {}

    ///
    public init(response: Bool) {
        self.response = response
    }
}

extension TKMobileAccess: TKDataResponse {
    public mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
