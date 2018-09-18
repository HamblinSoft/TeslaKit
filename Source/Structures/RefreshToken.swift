//
//  RefreshToken.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 5/24/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

/// Response Object
public enum RefreshToken {

    /// Refresh Token Request object containing the required information to receive a new accessToken
    public struct Request {

        /// Grant type should be "refresh_token"
        public var grantType: String? = nil

        /// Tesla API owner api client id
        public var clientId: String? = nil

        /// Tesla API owner api client secret
        public var clientSecret: String? = nil

        /// The the refresh token provided from the Tesla API
        public var refreshToken: String? = nil

        ///
        public init() {}

        ///
        public init(grantType: String?, clientId: String?, clientSecret: String?, refreshToken: String?) {
            self.grantType = grantType
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.refreshToken = refreshToken
        }

    }

    /// The response object returned containing an accessToken
    public typealias Response = AccessToken.Response
}

///
extension RefreshToken.Request: Mappable {

    public mutating func mapping(map: Map) {
        grantType <- map["grant_type"]
        clientId <- map["client_id"]
        clientSecret <- map["client_secret"]
        refreshToken <- map["refresh_token"]
    }
}
