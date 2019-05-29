//
//  SetSpeedLimitOptions.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 7/11/18.
//

import Foundation

///
public class SetSpeedLimitOptions: JSONCodable {

    ///
    public let limitMPH: Double

    ///
    public init(limitMPH: Double) {
        self.limitMPH = limitMPH
    }
    
    private enum CodingKeys: String, CodingKey {
        case limitMPH = "limit_mph"
    }
}
