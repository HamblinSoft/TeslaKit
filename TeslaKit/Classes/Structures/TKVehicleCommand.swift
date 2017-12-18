//
//  TKVehicleCommandResponse.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// The vehicle command response object indicating whether the command was issued successfully
public struct TKVehicleCommandResponse {

    /// Commmand result
    public var result: Bool = false

    /// Reason for the command result
    public var reason: String?

    /// Error
    public var error: String?

    /// Error Description
    public var errorDescription: String?

    ///
    public init() {}

    ///
    public init(result: Bool, reason: String) {
        self.result = result
        self.reason = reason
        self.error = reason
    }
}

extension TKVehicleCommandResponse: TKMappable {
    public mutating func mapping(map: Map) {
        result <- map["response.result"]
        reason <- map["response.reason"]
        error <- map["error"]
        errorDescription <- map["error_description"]
    }
}
