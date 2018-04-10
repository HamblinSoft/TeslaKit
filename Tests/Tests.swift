//
//  Tests.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
import TeslaKit

class Tests: XCTestCase {

    struct Credential {
        var email: String = ""
        var password: String = ""

        init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }

    lazy var credential: Credential = {
        do {
            guard let url: URL = Bundle.main.url(forResource: "TestAccount", withExtension: "json") else {
                fatalError("TestAccount.json not found")
            }
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data)
            let jsonObject = json as? [String: String] ?? [:]
            guard let email = jsonObject["email"], let password = jsonObject["password"], !email.isEmpty && !password.isEmpty else {
                fatalError("Email and Password required for TestAccount authentication.")
            }
            return Credential(email: email, password: password)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }()

    func testSignIn() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let expect = expectation(description: #function)

        let teslaAPI = TeslaAPI(ownerApiClientId: "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
                                ownerApiClientSecret: "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220")

        teslaAPI.accessToken(email: credential.email, password: credential.password) { (response, dataOrNil, errorOrNil) in
            expect.fulfill()
            XCTAssertEqual(response.statusCode, 200)
            XCTAssertNotNil(dataOrNil)
            print(dataOrNil as Any)
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
