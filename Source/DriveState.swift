//
//  DriveState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response object containing information about the driving and position state of the vehicle
public final class DriveState: JSONDecodable {

    ///
    public var shiftState: ShiftState = ShiftState.park

    ///
    public var speed: Int = 0

    ///
    public var longitude: Double = 0

    ///
    public var gpsAsOf: TimeInterval = 0

    ///
    public var power: Int = 0

    ///
    public var latitude: Double = 0

    ///
    public var headingValue: Double = 0

    ///
    public var timestamp: TimeInterval = 0

    ///
    public var nativeLocationSupported: Int = 0

    ///
    public var nativeType: String? = nil

    ///
    public var nativeLongitude: Double? = nil

    ///
    public var nativeLatitude: Double? = nil

    ///
    public var heading: Heading {
        switch Double(self.headingValue) {
        case 0..<22.5: return .north
        case 22.5..<67.5: return .northEast
        case 67.5..<112.5: return .east
        case 112.5..<157.5: return .southEast
        case 157.5..<202.5: return .south
        case 202.5..<247.5: return .southWest
        case 247.5..<292.5: return .west
        case 292.5..<337.5: return .northWest
        case 337.5..<360: return .north
        default: return .north
        }
    }

    ///
    public init() {}

    ///
    public init(from decoder: Decoder) throws {
        self.shiftState = try decoder.decodeIfPresent(CodingKeys.shiftState) ?? .park
        self.speed = try decoder.decodeIfPresent(CodingKeys.speed) ?? 0
        self.longitude = try decoder.decodeIfPresent(CodingKeys.longitude) ?? 0
        self.gpsAsOf = try decoder.decodeIfPresent(CodingKeys.gpsAsOf) ?? 0
        self.power = try decoder.decodeIfPresent(CodingKeys.power) ?? 0
        self.latitude = try decoder.decodeIfPresent(CodingKeys.latitude) ?? 0
        self.headingValue = try decoder.decodeIfPresent(CodingKeys.headingValue) ?? 0
        self.timestamp = try decoder.decodeIfPresent(CodingKeys.timestamp) ?? 0
        self.nativeLocationSupported = try decoder.decodeIfPresent(CodingKeys.nativeLocationSupported) ?? 0
        self.nativeType = try decoder.decodeIfPresent(CodingKeys.nativeType)
        self.nativeLongitude = try decoder.decodeIfPresent(CodingKeys.nativeLongitude)
        self.nativeLatitude = try decoder.decodeIfPresent(CodingKeys.nativeLatitude)
    }

    private enum CodingKeys: String, CodingKey {
        case gpsAsOf = "gps_as_of"
        case headingValue = "heading"
        case latitude = "latitude"
        case longitude = "longitude"
        case power = "power"
        case shiftState = "shift_state"
        case speed = "speed"
        case timestamp = "timestamp"
        case nativeLocationSupported = "native_location_supported"
        case nativeType = "native_type"
        case nativeLongitude = "native_longitude"
        case nativeLatitude = "native_latitude"
    }
}

//{
//    "shift_state" : "P",
//    "speed" : null,
//    "longitude" : -117.896179,
//    "gps_as_of" : 1513809832,
//    "power" : 0,
//    "latitude" : 33.782539,
//    "heading" : 172,
//    "timestamp" : 1513809833025
//}

