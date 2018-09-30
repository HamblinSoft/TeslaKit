//
//  VINTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
@testable import TeslaKit

fileprivate let VINModelS: String = "5YJSA1E2XHF156789"
fileprivate let VINModelX: String = "5YJXCAE45GFF00001"
fileprivate let VINModel3: String = "5YJ3E1A34A1P01234"
fileprivate let VINRoadster: String = "5YJRE1A31A1P01234"

class VINTests: XCTestCase {


    // MARK: - Model

    func testVinMakeModelS() {
        let vin = VIN(vinString: VINModelS)
        XCTAssertEqual(vin?.make, VINComponent.Make.modelS)
    }

    func testVinMakeModelX() {
        let vin = VIN(vinString: VINModelX)
        XCTAssertEqual(vin?.make, VINComponent.Make.modelX)
    }

    func testVinMakeModel3() {
        let vin = VIN(vinString: VINModel3)
        XCTAssertEqual(vin?.make, VINComponent.Make.model3)
    }

    func testVinMakeRoadster() {
        let vin = VIN(vinString: VINRoadster)
        XCTAssertEqual(vin?.make, VINComponent.Make.roadster)
    }

    // MARK: - Manufacturer

    func testVinManufacturerTesla() {
        let vin = VIN(vinString: VINModelS)
        XCTAssertEqual(vin?.manufacturer, .tesla)
    }

    func testVinManufacturerUnknown() {
        let vin = VIN(vinString: "0123456789012345")
        XCTAssertEqual(vin?.manufacturer, .unknown)
    }

    // MARK: - Body Type

    // MARK: - Restraint System

    // MARK: - Battery Type

    func testVinBatteryTypeElectric() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        XCTAssertEqual(vin?.batteryType, .electric)
    }

    func testVinBatteryTypeHighCapacity() {
        let vin = VIN(vinString: "5YJSA1H2XHF156789")
        XCTAssertEqual(vin?.batteryType, .highCapacity)
    }

    func testVinBatteryTypeStandardCapacity() {
        let vin = VIN(vinString: "5YJSA1S2XHF156789")
        XCTAssertEqual(vin?.batteryType, .standardCapacity)
    }

    func testVinBatteryTypeUltraCapacity() {
        let vin = VIN(vinString: "5YJSA1V2XHF156789")
        XCTAssertEqual(vin?.batteryType, .ultraCapacity)
    }

    func testVinBatteryTypeUnknown() {
        let vin = VIN(vinString: "5YJSA1Z2XHF156789")
        XCTAssertEqual(vin?.batteryType, .unknown)
    }

    // MARK: - Motor/Drive Unit

    func testVinDriveUnitSingleMotor() {
        let vin = VIN(vinString: "5YJSA1E1XHF156789")
        XCTAssertEqual(vin?.driveUnit, .singleMotor)
    }

    func testVinDriveUnitDualMotor() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        XCTAssertEqual(vin?.driveUnit, .dualMotor)
    }

    func testVinDriveUnitPerformanceSingleMotor() {
        let vin = VIN(vinString: "5YJSA1E3XHF156789")
        XCTAssertEqual(vin?.driveUnit, .performanceSingleMotor)
    }

    func testVinDriveUnitPerformanceDualMotor() {
        let vin = VIN(vinString: "5YJSA1E4XHF156789")
        XCTAssertEqual(vin?.driveUnit, .performanceDualMotor)
    }

    func testVinDriveUnitPerformance() {
        let vin = VIN(vinString: "5YJSA1EPXHF156789")
        XCTAssertEqual(vin?.driveUnit, .performance)

    }

    func testVinDriveUnitUnknown() {
        let vin = VIN(vinString: "5YJSA1EZXHF156789")
        XCTAssertEqual(vin?.driveUnit, .unknown)
    }

    // MARK: - Check Character

    func testVinCheckCharacter() {
        let vin = VIN(vinString: "5YJSA1E1XHF156789")
        XCTAssertEqual(vin?.checkCharacter, "X")
    }

    // MARK: - Model Year

    func testVinYears() {

        let testData: [(String, String)] = [
            ("6", "2006"),
            ("7", "2007"),
            ("8", "2008"),
            ("9", "2009"),
            ("A", "2010"),
            ("B", "2011"),
            ("C", "2012"),
            ("D", "2013"),
            ("E", "2014"),
            ("F", "2015"),
            ("G", "2016"),
            ("H", "2017"),
            ("I", "2018"),
            ("J", "2019"),
            ("K", "2020"),
            ("L", "2021"),
            ("M", "2022"),
            ("N", "2023"),
            ("O", "2024"),
            ("P", "2025")
        ]

        testData.forEach { (id, year) in
            let modelYear = VINComponent.ModelYear(rawValue: id)
            XCTAssertEqual(modelYear?.description, year)
        }
    }

    // MARK: - Location of Manufacture

    func testVinManufactureLocationFremont() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        XCTAssertEqual(vin?.manufactureLocation, .fremont)
    }

    func testVinManufactureLocationUnknown() {
        let vin = VIN(vinString: "5YJSA1E2XHZ156789")
        XCTAssertEqual(vin?.manufactureLocation, .unknown)
    }

    // MARK: - Serial Character

    func testVinSerialCharacter() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        XCTAssertEqual(vin?.serialCharacter, "1")
    }

    // MARK: - Serial Number

    func testVinSerialNumber() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        XCTAssertEqual(vin?.serialNo, "56789")
    }


    // MARK: - Example VINs

    func testVinModelS() {

        let vinNumber: String = "5YJSA1E2XHF156789"
        let vin = VIN(vinString: vinNumber)

        XCTAssertEqual(vin?.make, VINComponent.Make.modelS)
        XCTAssertEqual(vin?.modelYear, VINComponent.ModelYear.year2017)
    }

    // MARK: - Performance Tests

    func testVinDecodePerformance() {

        self.measure {
            _ = VIN(vinString: "5YJSA1E2XHF156789")
        }
    }

    // MARK: - Other

    func testVinCustomStringConvertible() {
        let vin = VIN(vinString: "5YJSA1E2XHF156789")
        print(vin as Any)
        VINComponent.BatteryType.allCases.forEach{print($0)}
        VINComponent.DriveUnit.allCases.forEach{print($0)}
        VINComponent.Make.allCases.forEach{print($0)}
        VINComponent.Manufacturer.allCases.forEach{print($0)}
        VINComponent.ManufactureLocation.allCases.forEach{print($0)}
        VINComponent.ModelYear.allCases.forEach{print($0)}
    }
}
