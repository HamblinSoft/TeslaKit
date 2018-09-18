//
//  RangeDisplay.swift
//  Tests
//
//  Created by Jaren Hamblin on 2/3/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public enum RangeDisplay: String, CustomStringConvertible {

    ///
    case ideal = "Ideal"

    ///
    case rated = "Rated"

    ///
    public var description: String {
        return self.rawValue
    }
}
