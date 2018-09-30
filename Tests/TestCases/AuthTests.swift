//
//  AuthTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
@testable import TeslaKit

open class AuthTests: TKTestCase {

    func testSignIn() {
        let testAccount = TestAccount.shared

        let expect = expectation(description: #function)

        let teslaAPI = TeslaAPI(configuration: .default, debugMode: true)
        
        // Get access token via credentials
        teslaAPI.getAccessToken(email: testAccount.email, password: testAccount.password) { (response, data, errorOrNil) in

            XCTAssertEqual(response.statusCode, 200)
            XCTAssertNotNil(data?.accessToken)
            teslaAPI.setAccessToken(data?.accessToken)

            // Get access token via refresh token
            teslaAPI.getRefreshToken(data?.refreshToken ?? "") { (response, data2, error) in

                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(data2?.accessToken)
                teslaAPI.setAccessToken(data2?.accessToken)

                // Revoke access token
                teslaAPI.revokeAccessToken { (response, _, error) in
                    XCTAssertEqual(response.statusCode, 200)
                    XCTAssertNil(error)

                    expect.fulfill()
                }
            }
        }

        waitForExpectations()
    }
}
