//
//  TKOpenTrunk.swift
//  Pods
//
//  Created by Jaren Hamblin on 2/1/18.
//

import Foundation
import ObjectMapper

///
public enum TKTrunkType: String {

    ///
    case front = "front"

    ///
    case rear = "rear"
}

///
public struct TKOpenTrunk {

    ///
    public var trunkType: TKTrunkType? = nil

    ///
    public init() {}

    ///
    public init(trunkType: TKTrunkType?) {
        self.trunkType = trunkType
    }
}

extension TKOpenTrunk: TKMappable {
    public mutating func mapping(map: Map) {
        trunkType <- (map["which_trunk"], EnumTransform())
    }
}
