//
//  TKHeading.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/24/17.
//

import Foundation

///
public enum TKHeading: String, CustomStringConvertible {

    ///
    case n

    ///
    case ne

    ///
    case e

    ///
    case se

    ///
    case s

    ///
    case sw

    ///
    case w

    ///
    case nw

    ///
    public var description: String {
        switch self {
        case .n: return "North"
        case .ne: return "North East"
        case .e: return "East"
        case .se: return "South East"
        case .s: return "South"
        case .sw: return "South West"
        case .w: return "West"
        case .nw: return "North West"
        }
    }

    public var abbreviation: String {
        return self.description.components(separatedBy: " ").map{$0.first}.compactMap{$0}.map{String($0)}.joined()
    }
}
