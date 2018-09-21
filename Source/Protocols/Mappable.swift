//
//  Mappable.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public typealias TKMappable = TeslaKit.Mappable

///
public protocol Mappable: ObjectMapper.Mappable {
    ///
    init()
}

///
public extension Mappable {

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
