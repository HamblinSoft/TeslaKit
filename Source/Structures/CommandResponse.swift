//
//  CommandResponse.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// The vehicle command response object indicating whether the command was issued successfully
public class CommandResponse: JSONDecodable {

    /// Commmand result
    public let result: Bool

    /// Reason for the command result
    public let reason: String?

    /// Error
    public let error: String? // TODO: Make this an error type

    /// Error Description
    public let errorDescription: String?

    ///
    public var allErrorMessages: String {
        return [self.errorDescription, self.reason, self.errorDescription].compactMap{$0}.joined(separator: ". ")
    }

    ///
    public init(result: Bool, reason: String) {
        self.result = result
        self.reason = reason
        self.error = reason
        self.errorDescription = reason
    }

    private enum CodingKeys: String, CodingKey {
        case result = "response.result"
        case reason = "response.reason"
        case error = "error"
        case errorDescription = "error_description"
    }
}
