//
//  TKGUISettings.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Returns various information about the GUI settings of the car, such as unit format and range display.
public struct TKGUISettings {
    
    /// Distance units (mi/hr)
    public var distanceUnits: TKDistanceUnit = TKDistanceUnit.kilometersPerHour

    /// Charge Rate units (mi/hr)
    public var chargeRateUnits: TKChargeUnit = TKChargeUnit.kilometersPerHour

    /// Temperature Units (F)
    public var temperatureUnits: TKTemperatureUnit = TKTemperatureUnit.celsius

    /// Indicates whether 24 hour time or 12 hour time is selected
    public var is24HourTime: Bool = false

    /// Range display time (Rated)
    public var rangeDisplay: TKRangeDisplay = TKRangeDisplay.rated

    /// Timestamp
    public var timestamp: TimeInterval = 0

    ///
    public var temperatureUnitsIsFahrenheit: Bool { return self.temperatureUnits == .fahrenheit }

    ///
    public init() {}
}

extension TKGUISettings: TKDataResponse {

    public mutating func mapping(map: Map) {
        chargeRateUnits <- (map["gui_charge_rate_units"], EnumTransform())
        is24HourTime <- map["gui_24_hour_time"]
        rangeDisplay <- (map["gui_range_display"], EnumTransform())
        temperatureUnits <- (map["gui_temperature_units"], EnumTransform())
        timestamp <- map["timestamp"]
        distanceUnits <- (map["gui_distance_units"], EnumTransform())
    }
}

//{
//    "gui_distance_units" : "mi\/hr",
//    "gui_charge_rate_units" : "mi\/hr",
//    "timestamp" : 1513809818903,
//    "gui_temperature_units" : "F",
//    "gui_24_hour_time" : false,
//    "gui_range_display" : "Rated"
//}
