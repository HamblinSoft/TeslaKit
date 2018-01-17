//
//  TKShiftState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

///
public enum TKShiftState: String {

    ///
    case drive = "D"

    ///
    case park = "P"

    ///
    case neutral = "N"

    ///
    case reverse = "R"

    ///
    public var displayName: String {
        switch self {
        case .drive: return "Drive"
        case .park: return "Park"
        case .neutral: return "Neutral"
        case .reverse: return "Reverse"
        }
    }
}
