//
//  NavigationRequestOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public class NavigationRequestOptions: JSONCodable {

    ///
    public var type: String?

    ///
    public var intent: NavigationRequestOptions.Intent?

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

    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case intent = "value"
        case locale = "locale"
        case timestamp = "timestamp_ms"
    }

    public class Intent: JSONCodable {

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

        private enum CodingKeys: String, CodingKey {
            case action = "android.intent.ACTION"
            case type = "android.intent.TYPE"
            case text = "android.intent.extra.TEXT"
        }
    }
}

