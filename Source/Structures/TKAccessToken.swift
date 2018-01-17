//
//  TKAccessToken.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public enum TKAccessToken {

    ///
    public struct Request {

        ///
        public var grantType: String? = nil

        ///
        public var clientId: String? = nil

        ///
        public var clientSecret: String? = nil

        ///
        public var email: String? = nil

        ///
        public var password: String? = nil

        ///
        public init() {}

        ///
        public init(grantType: String?, clientId: String?, clientSecret: String?, email: String?, password: String?) {
            self.grantType = grantType
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.email = email
            self.password = password
        }

    }

    ///
    public struct Response {

        ///
        public var accessToken: String? = nil

        ///
        public var tokenType: String? = nil

        ///
        public var expiresIn: TimeInterval? = nil

        ///
        public var createdAt: Date? = nil

        ///
        public var refreshToken: String? = nil
        
        ///
        public var isExpired: Bool {
            guard let createdAt = self.createdAt, let expiresIn = self.expiresIn, self.accessToken != nil && self.accessToken != "" else { return true }
            let expiryDate: Date = createdAt.addingTimeInterval(expiresIn)
            let isExpired: Bool = expiryDate <= Date()
            return isExpired
        }

        ///
        public init() {}

        ///
        public init(accessToken: String?, tokenType: String?, expiresIn: TimeInterval?, createdAt: Date?, refreshToken: String?) {
            self.accessToken = accessToken
            self.tokenType = tokenType
            self.expiresIn = expiresIn
            self.createdAt = createdAt
            self.refreshToken = refreshToken
        }
    }
}

///
extension TKAccessToken.Request: TKMappable {

    public mutating func mapping(map: Map) {
        grantType <- map["grant_type"]
        clientId <- map["client_id"]
        clientSecret <- map["client_secret"]
        email <- map["email"]
        password <- map["password"]
    }
}

///
extension TKAccessToken.Response: TKMappable {

    public mutating func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expiresIn <- map["expires_in"]
        createdAt <- (map["created_at"], DateTransform())
        refreshToken <- map["refresh_token"]
    }
}
