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
        teslaAPI.getAccessToken(email: testAccount.email, password: testAccount.password) { res in

            let response = res.httpResponse

            XCTAssertEqual(response.statusCode, 200)
            XCTAssertNotNil(res.data?.accessToken)
            teslaAPI.setAccessToken(res.data?.accessToken)

            // Get access token via refresh token
            teslaAPI.getRefreshToken(res.data?.refreshToken ?? "") { res2 in

                let response = res2.httpResponse

                XCTAssertEqual(response.statusCode, 200)
                XCTAssertNotNil(res2.data?.accessToken)
                teslaAPI.setAccessToken(res2.data?.accessToken)

                // Revoke access token
                teslaAPI.revokeAccessToken { res in
                    XCTAssertEqual(res.statusCode, 200)
                    XCTAssertNil(res.error)

                    expect.fulfill()
                }
            }
        }

        waitForExpectations()
    }
}
