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

        let teslaAPI = TeslaAPI(ownerApiClientId: "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
                                ownerApiClientSecret: "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220")

        teslaAPI.accessToken(email: testAccount.email, password: testAccount.password) { (response, dataOrNil, errorOrNil) in
            expect.fulfill()
            XCTAssertEqual(response.statusCode, 200)
            XCTAssertNotNil(dataOrNil?.accessToken)
        }

        waitForExpectations()
    }
}
