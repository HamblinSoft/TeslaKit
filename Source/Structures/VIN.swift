//
//  VIN.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/26/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct VIN {

    /// The minimum length to allow VIN parsing
    public static let minimumLength: Int = 15

    ///
    public var vinString: String = ""

    ///
    public var manufacturer: VINComponent.Manufacturer = VINComponent.Manufacturer.tesla

    ///
    public var make: VINComponent.Make = VINComponent.Make.modelS

    ///
    public var bodyType: String = ""

    ///
    public var restraintSystem: String = ""

    ///
    public var driveUnit: VINComponent.DriveUnit = VINComponent.DriveUnit.singleMotor

    ///
    public var checkCharacter: String = ""

    ///
    public var modelYear: VINComponent.ModelYear = VINComponent.ModelYear.unknown

    ///
    public var manufactureLocation: String = ""

    ///
    public var serialNo: String = ""

    ///
    public init() {}

    ///
    public init?(vinString: String) {
        guard vinString.count > VIN.minimumLength else { return nil }
        let vin: String = vinString.uppercased()
        self.vinString = vin
        self.manufacturer = VINComponent.Manufacturer(rawValue: String(vin[0..<3])) ?? VINComponent.Manufacturer.tesla
        self.make = VINComponent.Make(rawValue: String(vin[3..<4])) ?? VINComponent.Make.unknown
        self.bodyType = String(vin[4..<5])
        self.restraintSystem = String(vin[5..<6])
        self.driveUnit = VINComponent.DriveUnit(rawValue: String(vin[6..<7])) ?? VINComponent.DriveUnit.singleMotor
        self.checkCharacter = String(vin[7..<8])
        self.modelYear = VINComponent.ModelYear(rawValue: String(vin[8..<9])) ?? VINComponent.ModelYear.unknown
        self.manufactureLocation = String(vin[9..<10])
        self.serialNo = String(vin[10...vin.count-1])
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

extension VIN: TKMappable {
    public mutating func mapping(map: Map) {
        
    }
}
