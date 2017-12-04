//
//  TAMappable.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public protocol TAMappable: Mappable {
    ///
    init()
}

///
public extension TAMappable {

    ///
    public init() {
        self.init()
    }

    ///
    public init?(map: Map) {
        self.init()
    }

    ///
    public var data: Data? { return try? JSONSerialization.data(withJSONObject: self.toJSON()) }
}
