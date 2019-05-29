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

            teslaAPI.vehicles { res in

                XCTAssertEqual(res.httpResponse.statusCode, 200)
                XCTAssertNil(res.error)
                XCTAssertNotNil(res.data)

                let vehicles = res.data?.vehicles ?? []
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

            teslaAPI.vehicles { res in

                guard let vehicle = res.data?.vehicles.first else {
                    expect.fulfill()
                    XCTFail("At least one vehicle must be assiciated with the credential test account to run this test")
                    return
                }

                teslaAPI.data(for: vehicle) { res in

                    XCTAssertEqual(res.httpResponse.statusCode, 200)
                    XCTAssertNil(res.error)
                    XCTAssertNotNil(res.data)

                    expect.fulfill()
                }
            }
        }

        waitForExpectations()
    }
}
