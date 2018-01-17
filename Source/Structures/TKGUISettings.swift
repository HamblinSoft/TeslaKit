//
//  TKGUISettings.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

/// Returns various information about the GUI settings of the car, such as unit format and range display.
public struct TKGUISettings {
    
    ///
    public var guiDistanceUnits: String? = nil

    // TODO: Complete other properties

    public var gui_charge_rate_units: String? = nil
    public var timestamp: Int = 0
    public var gui_temperature_units: String? = nil
    public var gui_24_hour_time: Bool = false
    public var gui_range_display: String? = nil

    ///
    public init() {}
}

extension TKGUISettings: TKDataResponse {

    public mutating func mapping(map: Map) {
        guiDistanceUnits <- map["gui_distance_units"]
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
