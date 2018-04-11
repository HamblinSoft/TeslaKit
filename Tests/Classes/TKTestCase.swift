//
//  Tests.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
import TeslaKit

open class TKTestCase: XCTestCase {


    open func signIn(completion: @escaping (TeslaAPI) -> Void) {

        let testAccount = TestAccount.shared

        let teslaAPI = TeslaAPI(ownerApiClientId: "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
                                ownerApiClientSecret: "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220")
        teslaAPI.debugMode = true

        if let accessToken = testAccount.accessToken?.accessToken, testAccount.accessToken?.isExpired == false {
            teslaAPI.setAccessToken(accessToken)
            completion(teslaAPI)
        } else {
            teslaAPI.accessToken(email: testAccount.email, password: testAccount.password) { (httpResponse, dataOrNil, errorOrNil) in
                teslaAPI.setAccessToken(dataOrNil?.accessToken)
                testAccount.accessToken = dataOrNil
                completion(teslaAPI)
            }
        }
    }


    func waitForExpectations(timeout: ExpectationWait = ExpectationWait.default) {
        waitForExpectations(timeout: timeout.rawValue, handler: nil)
    }
}
