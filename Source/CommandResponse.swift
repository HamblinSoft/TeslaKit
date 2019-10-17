//
//  CommandResponse.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

/// The vehicle command response object indicating whether the command was issued successfully
public final class CommandResponse: JSONDecodable {

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

    public init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try responseContainer.decodeIfPresent(String.self, forKey: .error)
        self.errorDescription = try responseContainer.decodeIfPresent(String.self, forKey: .errorDescription)

        let container = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        self.result = try container.decodeIfPresent(Bool.self, forKey: .result) ?? false
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason) ?? ""
    }

    private enum CodingKeys: String, CodingKey {
        case response = "response"
        case result = "result"
        case reason = "reason"
        case error = "error"
        case errorDescription = "error_description"
    }
}

//{
//  "response" : {
//    "result" : true,
//    "reason" : ""
//  }
//}
