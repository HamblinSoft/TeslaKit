//
//  RemoteStart.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
public struct RemoteStart {

    /// The password to the authenticated my.teslamotors.com account.
    public var password: String = ""

    ///
    public init() {}

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - password: The password to the authenticated my.teslamotors.com account.
    public init(password: String) {
        self.password = password
    }
}

extension RemoteStart: Mappable {
    public mutating func mapping(map: Map) {
        password <- map["password"]
    }
}
