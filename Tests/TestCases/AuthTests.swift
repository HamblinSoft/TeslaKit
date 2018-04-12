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

        let teslaAPI = TeslaAPI()

        teslaAPI.accessToken(email: testAccount.email, password: testAccount.password) { (response, dataOrNil, errorOrNil) in
            expect.fulfill()
            XCTAssertEqual(response.statusCode, 200)
            XCTAssertNotNil(dataOrNil?.accessToken)
        }

        waitForExpectations()
    }
}
