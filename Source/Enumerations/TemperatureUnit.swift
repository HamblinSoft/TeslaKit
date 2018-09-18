//
//  TemperatureUnit.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public enum TemperatureUnit: String, CustomStringConvertible {

    ///
    case fahrenheit = "F"

    ///
    case celsius = "C"

    public var description: String {
        switch self {
        case .fahrenheit: return "Fahrenheit"
        case .celsius: return "Celsius"
        }
    }
}
