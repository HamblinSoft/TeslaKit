//
//  GUISettings.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Returns various information about the GUI settings of the car, such as unit format and range display.
public final class GUISettings: JSONDecodable {
    
    /// Distance units (mi/hr)
    public var distanceUnits: DistanceUnit = DistanceUnit.metric

    /// Charge Rate units (mi/hr)
    public var chargeRateUnits: ChargeUnit = ChargeUnit.metric

    /// Temperature Units (F)
    public var temperatureUnits: TemperatureUnit = TemperatureUnit.celsius

    /// Indicates whether 24 hour time or 12 hour time is selected
    public var is24HourTime: Bool = false

    /// Range display time (Rated)
    public var rangeDisplay: RangeDisplay = RangeDisplay.rated

    /// Timestamp
    public var timestamp: TimeInterval = 0

    ///
    public var temperatureUnitsIsFahrenheit: Bool { return self.temperatureUnits == .fahrenheit }

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.distanceUnits = try decoder.decodeIfPresent(CodingKeys.distanceUnits) ?? .metric
        self.chargeRateUnits = try decoder.decodeIfPresent(CodingKeys.chargeRateUnits) ?? .metric
        self.temperatureUnits = try decoder.decodeIfPresent(CodingKeys.temperatureUnits) ?? .celsius
        self.is24HourTime = try decoder.decodeIfPresent(CodingKeys.is24HourTime) ?? false
        self.rangeDisplay = try decoder.decodeIfPresent(CodingKeys.rangeDisplay) ?? .rated
        self.timestamp = try decoder.decodeIfPresent(CodingKeys.timestamp) ?? 0
    }

    private enum CodingKeys: String, CodingKey {
        case chargeRateUnits = "gui_charge_rate_units"
        case is24HourTime = "gui_24_hour_time"
        case rangeDisplay = "gui_range_display"
        case temperatureUnits = "gui_temperature_units"
        case timestamp = "timestamp"
        case distanceUnits = "gui_distance_units"
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
