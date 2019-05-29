//
//  AccessToken.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// Response Object
public enum AccessToken {

    /// AccessToken Request object containing the required information to receive an accessToken
    public class Request: JSONCodable {

        /// Grant type should be "password"
        public let grantType: String?

        /// Tesla API owner api client id
        public let clientId: String?

        /// Tesla API owner api client secret
        public let clientSecret: String?

        /// The email address of a user
        public let email: String?

        /// The password of a user
        public let password: String?

        ///
        public init(grantType: String?, clientId: String?, clientSecret: String?, email: String?, password: String?) {
            self.grantType = grantType
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.email = email
            self.password = password
        }

        private enum CodingKeys: String, CodingKey {
            case grantType = "grant_type"
            case clientId = "client_id"
            case clientSecret = "client_secret"
            case email = "email"
            case password = "password"
        }
    }

    /// The response object returned containing an accessToken
    public class Response: JSONCodable {

        /// The accessToken that needs to be included with each request to obtain vehicle data and send vehicle commands
        public var accessToken: String? = nil

        /// The type of token
        public var tokenType: String? = nil

        /// When the access token expires
        public var expiresIn: TimeInterval? = nil

        /// The date the access token was created at
        public var createdAt: Date? = nil

        /// A refresh token
        public var refreshToken: String? = nil
        
        /// Returns whether the accessToken obejct is valid or has expired
        public var isExpired: Bool {
            guard let createdAt = self.createdAt, let expiresIn = self.expiresIn, self.accessToken != nil && self.accessToken != "" else { return true }
            let expiryDate: Date = createdAt.addingTimeInterval(expiresIn)
            let isExpired: Bool = expiryDate <= Date()
            return isExpired
        }

        ///
        public init(accessToken: String?, tokenType: String?, expiresIn: TimeInterval?, createdAt: Date?, refreshToken: String?) {
            self.accessToken = accessToken
            self.tokenType = tokenType
            self.expiresIn = expiresIn
            self.createdAt = createdAt
            self.refreshToken = refreshToken
        }

        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case expiresIn = "expires_in"
            case createdAt = "created_at"
            case refreshToken = "refresh_token"
        }
    }
}
