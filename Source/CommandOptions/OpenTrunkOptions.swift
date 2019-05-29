//
//  OpenTrunk.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 2/1/18.
//

import Foundation

///
public class OpenTrunkOptions: JSONCodable {

    ///
    public let trunkType: TrunkType

    ///
    public init(trunkType: TrunkType) {
        self.trunkType = trunkType
    }

    private enum CodingKeys: String, CodingKey {
        case trunkType = "which_trunk"
    }
}
