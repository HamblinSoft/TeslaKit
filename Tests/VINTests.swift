//
//  VINTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 JJJJaren. All rights reserved.
//

import XCTest
import TeslaKit

fileprivate let VINModelS: String = "5YJSA1E2XHF156789"
fileprivate let VINModelX: String = "5YJXCAE45GFF00001"
fileprivate let VINModel3: String = "5YJ3E1A34A1P01234"
fileprivate let VINRoadster: String = "5YJRE1A31A1P01234"

class VINTests: XCTestCase {

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
            XCTAssertEqual(modelYear?.name, year)
        }
    }
}
