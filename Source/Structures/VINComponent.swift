//
//  VINComponent.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/26/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public struct VINComponent {

    ///
    public enum Manufacturer: String, CustomStringConvertible, CaseIterable {

        ///
        case unknown = ""

        ///
        case tesla = "5YJ"

        ///
        public var description: String {
            switch self {
            case .unknown: return "Unknown"
            case .tesla: return "Tesla"
            }
        }
    }

    ///
    public enum Make: String, CustomStringConvertible, CaseIterable {

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

        ///
        public var description: String {
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
    public enum BatteryType: String, CustomStringConvertible, CaseIterable {

        ///
        case unknown

        ///
        case electric = "E"

        ///
        case highCapacity = "H"

        ///
        case standardCapacity = "S"

        ///
        case ultraCapacity = "V"

        ///
        public var description: String {
            switch self {
            case .unknown: return "Unknown"
            case .electric: return "Electric"
            case .highCapacity: return "High Capacity"
            case .standardCapacity: return "Standard Capacity"
            case .ultraCapacity: return "Ultra Capacity"
            }
        }
    }

    ///
    public enum DriveUnit: String, CustomStringConvertible, CaseIterable {

        ///
        case unknown

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

        ///
        public var description: String {
            switch self {
            case .unknown: return "Unknown"
            case .singleMotor: return "Single Motor"
            case .dualMotor: return "Dual Motor"
            case .performanceSingleMotor: return "Performance Single Motor"
            case .performanceDualMotor: return "Performance Dual Motor"
            case .performance: return "Performance"
            }
        }
    }

    ///
    public enum ManufactureLocation: String, CustomStringConvertible, CaseIterable {

        ///
        case unknown = ""

        ///
        case fremont = "F"

        ///
        public var description: String {
            switch self {
            case .unknown: return "Unknown"
            case .fremont: return "Fremont, CA, USA"
            }
        }
    }

    ///
    public enum ModelYear: String, CaseIterable {

        ///
        case unknown = ""

        ///
        case year2024 = "P"

        ///
        case year2023 = "O"

        ///
        case year2022 = "N"

        ///
        case year2021 = "M"

        ///
        case year2020 = "L"

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
        case year2009 = "9"

        ///
        case year2008 = "8"

        ///
        case year2007 = "7"

        ///
        case year2006 = "6"

        ///
        public var description: String {
            return String(describing: self).replacingOccurrences(of: "year", with: "")
        }
    }
}
