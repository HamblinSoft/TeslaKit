//
//  TKGUISettings.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKGUISettings {

    ///
    public struct Response {

        ///
        public var guiDistanceUnits: String? = nil

        // TODO: Complete other properties

        var gui_charge_rate_units: String? = nil
        var timestamp: Int = 0
        var gui_temperature_units: String? = nil
        var gui_24_hour_time: Bool = false
        var gui_range_display: String? = nil

        ///
        public init() {}
    }
}

extension TKGUISettings.Response: TKDataRequestResponse {

    public mutating func mapping(map: Map) {
        guiDistanceUnits <- map["response.gui_distance_units"]
    }
}

//{
//    "response" : {
//        "gui_distance_units" : "mi\/hr",
//        "gui_charge_rate_units" : "mi\/hr",
//        "timestamp" : 1511681566783,
//        "gui_temperature_units" : "F",
//        "gui_24_hour_time" : false,
//        "gui_range_display" : "Rated"
//    }
//}

