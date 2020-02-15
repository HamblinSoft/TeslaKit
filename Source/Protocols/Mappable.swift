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
    init() {
        self.init()
    }

    ///
    init?(map: Map) {
        self.init()
    }

    ///
    var data: Data? { return try? JSONSerialization.data(withJSONObject: self.toJSON()) }
}
