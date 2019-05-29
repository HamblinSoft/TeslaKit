//
//  MediaState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public class MediaState: JSONDecodable {

    ///
    public var remoteControlEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(remoteControlEnabled: Bool) {
        self.remoteControlEnabled = remoteControlEnabled
    }

    private enum CodingKeys: String, CodingKey {
        case remoteControlEnabled = "remote_control_enabled"
    }
}
