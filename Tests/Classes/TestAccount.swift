//
//  TestAccount.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import TeslaKit

class TestAccount {
    var email: String = ""
    var password: String = ""
    var accessToken: AccessToken.Response? = nil

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    static var shared: TestAccount = {
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
            return TestAccount(email: email, password: password)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }()
}
