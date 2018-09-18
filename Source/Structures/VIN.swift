//
//  VIN.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/26/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct VIN: CustomStringConvertible {

    /// The minimum length to allow VIN parsing
    public static let minimumLength: Int = 15

    ///
    public var vinString: String = ""

    ///
    public var manufacturer: VINComponent.Manufacturer = .unknown

    ///
    public var make: VINComponent.Make = .unknown

    ///
    public var bodyType: String = ""

    ///
    public var restraintSystem: String = ""

    ///
    public var batteryType: VINComponent.BatteryType = .unknown

    ///
    public var driveUnit: VINComponent.DriveUnit = .unknown

    ///
    public var checkCharacter: String = ""

    ///
    public var modelYear: VINComponent.ModelYear = .unknown

    ///
    public var manufactureLocation: VINComponent.ManufactureLocation = .unknown

    ///
    public var serialCharacter: String = ""

    ///
    public var serialNo: String = ""

    ///
    public init() {}

    ///
    public init?(vinString: String) {
        guard vinString.count > VIN.minimumLength else { return nil }
        let vin: String = vinString.uppercased()
        self.vinString = vin
        self.manufacturer = VINComponent.Manufacturer(rawValue: String(vin[0..<3])) ?? .unknown
        self.make = VINComponent.Make(rawValue: String(vin[3..<4])) ?? .unknown
        self.bodyType = String(vin[4..<5])
        self.restraintSystem = String(vin[5..<6])
        self.batteryType = VINComponent.BatteryType(rawValue: String(vin[6..<7])) ?? .unknown
        self.driveUnit = VINComponent.DriveUnit(rawValue: String(vin[7..<8])) ?? .unknown
        self.checkCharacter = String(vin[8..<9])
        self.modelYear = VINComponent.ModelYear(rawValue: String(vin[9..<10])) ?? .unknown
        self.manufactureLocation = VINComponent.ManufactureLocation(rawValue: String(vin[10..<11])) ?? .unknown
        self.serialCharacter = String(vin[11..<12])
        self.serialNo = String(vin[12...vin.count-1])
    }

    ///
    public var description: String {
        return self.vinString
    }
}

extension String {
    fileprivate subscript (bounds: CountableClosedRange<Int>) -> String {
        guard self.count > VIN.minimumLength else { return "" }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    fileprivate subscript (bounds: CountableRange<Int>) -> String {
        guard self.count > VIN.minimumLength else { return "" }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension VIN: Mappable {
    public mutating func mapping(map: Map) {
        
    }
}
