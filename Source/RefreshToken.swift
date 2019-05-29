//
//  RefreshToken.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 5/24/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response Object
public enum RefreshToken {

    /// Refresh Token Request object containing the required information to receive a new accessToken
    public class Request: JSONCodable {

        /// Grant type should be "refresh_token"
        public let grantType: String?

        /// Tesla API owner api client id
        public let clientId: String?

        /// Tesla API owner api client secret
        public let clientSecret: String?

        /// The the refresh token provided from the Tesla API
        public let refreshToken: String?

        ///
        public init(grantType: String?, clientId: String?, clientSecret: String?, refreshToken: String?) {
            self.grantType = grantType
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.refreshToken = refreshToken
        }

        private enum CodingKeys: String, CodingKey {
            case grantType = "grant_type"
            case clientId = "client_id"
            case clientSecret = "client_secret"
            case refreshToken = "refresh_token"
        }
    }

    /// The response object returned containing an accessToken
    public typealias Response = AccessToken.Response
}
