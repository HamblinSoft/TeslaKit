//
//  DistanceUnit.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public enum DistanceUnit: String, CustomStringConvertible {

    ///
    case imperial = "mi/hr"

    ///
    case metric = "km/hr"

    ///
    public var description: String {
        switch self {
        case .imperial:
            return "Imperial (MPH)"
        case .metric:
            return "Metric (KPH)"
        }
    }
}
