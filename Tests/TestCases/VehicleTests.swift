//
//  VehicleTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
@testable import TeslaKit

class VehicleTests: TKTestCase {


    // MARK: - Vehicle List

    func testVehicleList() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.getVehicles { (httpResponse, dataOrNil, errorOrNil) in

                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                XCTAssertNotNil(dataOrNil)

                let vehicles = dataOrNil?.vehicles ?? []
                XCTAssertGreaterThan(vehicles.count, 0)

                expect.fulfill()
            }
        }

        waitForExpectations()
    }


    // MARK: - Vehicle Data

    func testVehicleData() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.getVehicles { (httpResponse, dataOrNil, errorOrNil) in

                guard let vehicle = dataOrNil?.vehicles.first else {
                    expect.fulfill()
                    XCTFail("At least one vehicle must be assiciated with the credential test account to run this test")
                    return
                }

                teslaAPI.getData(for: vehicle) { (httpResponse, vehicleOrNil, errorOrNil) in

                    XCTAssertEqual(httpResponse.statusCode, 200)
                    XCTAssertNil(errorOrNil)
                    XCTAssertNotNil(vehicleOrNil)

                    expect.fulfill()
                }
            }
        }

        waitForExpectations()
    }
}
