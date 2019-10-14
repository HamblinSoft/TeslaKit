//
//  MediaState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public final class MediaState: JSONDecodable {

    ///
    public var remoteControlEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(remoteControlEnabled: Bool) {
        self.remoteControlEnabled = remoteControlEnabled
    }

    ///
    public init(from decoder: Decoder) throws {
        self.remoteControlEnabled = try decoder.decodeIfPresent(CodingKeys.remoteControlEnabled) ?? false
    }

    private enum CodingKeys: String, CodingKey {
        case remoteControlEnabled = "remote_control_enabled"
    }
}
