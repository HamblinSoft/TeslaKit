//
//  TKDistanceUnit.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public enum TKDistanceUnit: String, CustomStringConvertible {

    ///
    case milesPerHour = "mi/hr"

    ///
    case kilometersPerHour = "km/hr"

    public var description: String {
        return self.rawValue
    }
}
