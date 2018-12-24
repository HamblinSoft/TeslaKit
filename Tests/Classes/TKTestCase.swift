//
//  Tests.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
import TeslaKit
import ObjectMapper

open class TKTestCase: XCTestCase {


    open func signIn(completion: @escaping (TeslaAPI) -> Void) {

        let testAccount = TestAccount.shared

        let teslaAPI = TeslaAPI(configuration: TeslaAPI.Configuration.default, debugMode: true)

        if let accessToken = testAccount.accessToken?.accessToken, testAccount.accessToken?.isExpired == false {
            teslaAPI.setAccessToken(accessToken)
            completion(teslaAPI)
        } else {
            teslaAPI.getAccessToken(email: testAccount.email, password: testAccount.password) { (httpResponse, dataOrNil, errorOrNil) in
                teslaAPI.setAccessToken(dataOrNil?.accessToken)
                testAccount.accessToken = dataOrNil
                completion(teslaAPI)
            }
        }
    }


    func waitForExpectations(timeout: ExpectationWait = ExpectationWait.default) {
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
    }

    func testScheduled() {
        let ts: TimeInterval = 1545652800

        var cs1 = ChargeState()
        cs1.scheduledChargingStartTime = Date(timeIntervalSince1970: ts)
        XCTAssertNotNil(cs1.scheduledChargingStartTime)
        print(cs1.scheduledChargingStartTime)


        let cs2 = ChargeState(JSON: ["scheduled_charging_start_time" : ts])!
        XCTAssertNotNil(cs2.scheduledChargingStartTime)
        print(cs2.scheduledChargingStartTime)

        let transform = DateTransform()
        let date = transform.transformFromJSON(ts)
        XCTAssertNotNil(date)
        print(date)
    }
}
