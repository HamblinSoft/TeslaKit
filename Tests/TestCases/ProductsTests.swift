//
//  ProductsTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
@testable import TeslaKit

class ProductsTests: TKTestCase {


    func testProducts() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.products { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations()
    }

    func testBatterySOC() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.batterySOC { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations()
    }


    func testMeterAggregates() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.meterAggregates { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testPowerWalls() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.powerWalls { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations()
    }

    func testConnectionStatus() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.connectionStatus { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations()
    }

    func testVersionStatus() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.versionStatus { (httpResponse, dataOrNil, errorOrNil) in
                XCTAssertEqual(httpResponse.statusCode, 200)
                XCTAssertNil(errorOrNil)
                expect.fulfill()
            }
        }

        waitForExpectations()
    }
}
