//
//  OpenTrunk.swift
//  Pods
//
//  Created by Jaren Hamblin on 2/1/18.
//

import Foundation
import ObjectMapper

///
public enum TrunkType: String {

    ///
    case front = "front"

    ///
    case rear = "rear"
}

///
public struct OpenTrunk {

    ///
    public var trunkType: TrunkType? = nil

    ///
    public init() {}

    ///
    public init(trunkType: TrunkType?) {
        self.trunkType = trunkType
    }
}

extension OpenTrunk: Mappable {
    public mutating func mapping(map: Map) {
        trunkType <- (map["which_trunk"], EnumTransform())
    }
}
