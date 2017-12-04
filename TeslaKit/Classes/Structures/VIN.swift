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

    ///
    public var vin: String = ""

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
    public var modelYear: String = ""

    ///
    public var manufactureLocation: String = ""

    ///
    public var serialNo: String = ""

    ///
    public init() {}

    ///
    public init(vinString: String) {
        let vin: String = vinString.uppercased()
        self.vin = vin
        self.manufacturer = VINComponent.Manufacturer(rawValue: String(vin[0..<4])) ?? VINComponent.Manufacturer.tesla
        self.make = VINComponent.Make(rawValue: String(vin[4..<5])) ?? VINComponent.Make.modelS
        self.bodyType = String(vin[5..<6])
        self.restraintSystem = String(vin[6..<7])
        self.driveUnit = VINComponent.DriveUnit(rawValue: String(vin[7..<8])) ?? VINComponent.DriveUnit.singleMotor
        self.checkCharacter = String(vin[8..<9])
        self.modelYear = String(vin[9..<10])
        self.manufactureLocation = String(vin[10..<11])
        self.serialNo = String(vin[11...vin.count-1])
    }
}

extension String {
    fileprivate subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    fileprivate subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

extension VIN: TAMappable {
    public mutating func mapping(map: Map) {

    }
}
