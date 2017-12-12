//
//  TKVehicleSummary.swift
//  Alamofire-iOS
//
//  Created by Jaren Hamblin on 12/8/17.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleSummary {

    // MARK: - Vehicle Info

    ///
    public var vehicleId: Int = 0

    ///
    public var displayName: String = ""

    ///
    public var vin: VIN?


    // MARK: - Charge State

    ///
    public var chargingState: TKChargingState = TKChargingState.complete

    ///
    public var batteryLevel: Double = 0.0

    ///
    public var batteryRange: Double = 0.0

    // MARK: - Climate State

    // MARK - Drive State

    ///
    public var latitude: Double?

    ///
    public var longitude: Double?


    // MARK: - GUI Settings

    ///
    public var distanceUnits: String?

    // MARK: - Vehicle State

    ///
    public var exteriorColor: String?

    ///
    public var odometer: Double = 0

    
    ///
    public init() {}

    ///
    public init(vehicleId: Int, displayName: String, vin: VIN?, chargingState: TKChargingState, batteryLevel: Double, batteryRange: Double, latitude: Double?, longitude: Double?, distanceUnits: String?, exteriorColor: String?, odometer: Double) {
        self.vehicleId = vehicleId
        self.displayName = displayName
        self.vin = vin
        self.chargingState = chargingState
        self.batteryLevel = batteryLevel
        self.batteryRange = batteryRange
        self.latitude = latitude
        self.longitude = longitude
        self.distanceUnits = distanceUnits
        self.exteriorColor = exteriorColor
        self.odometer = odometer
    }
}

extension TKVehicleSummary: TKMappable {
    public mutating func mapping(map: Map) {
        vehicleId <- map["vehicleId"]
        displayName <- map["displayName"]
        vin <- (map["vin"], VINTransform())
        chargingState <- (map["chargingState"], EnumTransform())
        batteryLevel <- map["batteryLevel"]
        batteryRange <- map["batteryRange"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        distanceUnits <- map["distanceUnits"]
        exteriorColor <- map["exteriorColor"]
        odometer <- map["odometer"]
    }
}

extension TKVehicleSummary: Equatable {
    public static func == (lhs: TKVehicleSummary, rhs: TKVehicleSummary) -> Bool {
        return lhs.batteryLevel == rhs.batteryLevel
            && lhs.batteryRange == rhs.batteryRange
    }
}

