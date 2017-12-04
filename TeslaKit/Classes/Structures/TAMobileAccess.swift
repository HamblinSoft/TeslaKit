//
//  TAMobileAccess.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TAMobileAccess {

    ///
    public struct Response {

        ///
        public var response: Bool = false

        ///
        public init() {}

        ///
        public init(response: Bool) {
            self.response = response
        }
    }
}

extension TAMobileAccess.Response: TADataRequestResponse {
    public mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
