//
//  TKMappable.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public protocol TKMappable: Mappable {
    ///
    init()
}

///
public extension TKMappable {

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
