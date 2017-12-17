//
//  TKPanoRoofState.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

/// The desired state of the panoramic roof. The approximate percent open values for each state are open = 100%, close = 0%, comfort = 80%, and vent = ~15% Example: open. Possible values:  open , close , comfort , vent , move .
public struct enum TKPanoRoofState: String {

    /// close = 0%
    case close

    /// vent = ~15%
    case vent

    /// comfort = 80%
    case comfort

    /// open = 100%
    case open

    ///
    case move
}
