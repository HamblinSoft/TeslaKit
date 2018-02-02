//
//  VINComponent.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/26/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

///
public struct VINComponent {

    ///
    public enum Manufacturer: String {

        ///
        case tesla = "5YJ"
    }

    ///
    public enum Make: String {

        ///
        case unknown = ""

        ///
        case roadster = "R"

        ///
        case modelS = "S"

        ///
        case modelX = "X"

        ///
        case model3 = "3"

        /// A readable display name
        public var name: String {
            switch self {
            case .unknown: return "Unknown"
            case .roadster: return "Roadster"
            case .modelS: return "Model S"
            case .modelX: return "Model X"
            case .model3: return "Model 3"
            }
        }
    }

    ///
    public enum BatteryType: String {

        ///
        case electric = "E"

        ///
        case highCapacity = "H"

        ///
        case standardCapacity = "S"

        ///
        case ultraCapacity = "V"
    }

    ///
    public enum DriveUnit: String {

        ///
        case singleMotor = "1"

        ///
        case dualMotor = "2"

        ///
        case performanceSingleMotor = "3"

        ///
        case performanceDualMotor = "4"

        ///
        case performance = "P"
    }

    ///
    public enum ModelYear: String {

        ///
        case unknown = ""

        ///
        case year2019 = "K"

        ///
        case year2018 = "J"

        ///
        case year2017 = "H"

        ///
        case year2016 = "G"

        ///
        case year2015 = "F"

        ///
        case year2014 = "E"

        ///
        case year2013 = "D"

        ///
        case year2012 = "C"

        ///
        case year2011 = "B"

        ///
        case year2010 = "A"

        ///
        public var name: String {
            return String(describing: self).replacingOccurrences(of: "year", with: "")
        }
    }
}
