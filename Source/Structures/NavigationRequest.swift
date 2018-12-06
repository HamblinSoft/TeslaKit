//
//  NavigationRequest.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct NavigationRequest: TKMappable {

    ///
    public var type: String?

    ///
    public var intent: NavigationRequest.Intent?

    ///
    public var locale: String?

    ///
    public var timestamp: String?

    public init(address: String) {
        self.intent = Intent(address: address.replacingOccurrences(of: "\n", with: " "))
        self.type = "share_ext_content_raw"
        self.locale = "en-US"
        self.timestamp = "12345"
    }

    ///
    public init() {}

    ///
    public mutating func mapping(map: Map) {
        type <- map["type"]
        intent <- map["value"]
        locale <- map["locale"]
        timestamp <- map["timestamp_ms"]
    }

    public struct Intent: TKMappable {

        ///
        public var action: String?

        ///
        public var type: String?

        ///
        public var text: String?

        ///
        public init(address: String) {
            self.action = "android.intent.action.SEND"
            self.type = "text%2F%0Aplain"
            self.text = "Place Name\n\(address)\n(123) 123-1234\nhttps://maps.google.com/?cid=12345"
        }

        ///
        public mutating func mapping(map: Map) {
            action <- map["android.intent.ACTION", nested: false]
            type <- map["android.intent.TYPE", nested: false]
            text <- map["android.intent.extra.TEXT", nested: false]
        }
    }
}

