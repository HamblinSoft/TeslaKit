//
//  ChargePortLatchState.swift
//  Pods
//
//  Created by Jaren Hamblin on 2/5/18.
//

import Foundation

/// The state of the charge port latch. The charge port latch locks the charging connector to the vehicle.
public enum ChargePortLatchState: String, CustomStringConvertible {

    ///
    case unknown = ""

    ///
    case disengaged = "Disengaged"

    ///
    case engaged = "Engaged"

    ///
    public var description: String {
        return self.rawValue
    }
}
