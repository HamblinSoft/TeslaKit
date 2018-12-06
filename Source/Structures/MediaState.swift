//
//  MediaState.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct MediaState: TKMappable {

    ///
    public var remoteControlEnabled: Bool = false

    ///
    public init() {}

    ///
    public init(remoteControlEnabled: Bool) {
        self.remoteControlEnabled = remoteControlEnabled
    }

    ///
    public mutating func mapping(map: Map) {
        remoteControlEnabled <- map["remote_control_enabled"]
    }
}
