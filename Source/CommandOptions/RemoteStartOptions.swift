//
//  RemoteStartOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
public class RemoteStartOptions: JSONCodable {

    /// The password to the authenticated my.teslamotors.com account.
    public let password: String

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
    ///
    /// - Parameters:
    ///   - vehicleId: The id of the Vehicle. Example: 1.
    ///   - password: The password to the authenticated my.teslamotors.com account.
    public init(password: String) {
        self.password = password
    }

    private enum CodingKeys: String, CodingKey {
        case password
    }
}
