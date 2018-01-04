//
//  TKDirection.swift
//  Pods
//
//  Created by Jaren Hamblin on 12/24/17.
//

import Foundation

///
public enum TKDirection: String {

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
    public var displayName: String {
        switch self {

        case .n:
            return "North"
        case .ne:
            return "North East"
        case .e:
            return "East"
        case .se:
            return "South East"
        case .s:
            return "South"
        case .sw:
            return "South West"
        case .w:
            return "West"
        case .nw:
            return "North West"
        }
    }

    public var shortName: String {
        return self.displayName.components(separatedBy: " ").map{$0.first}.flatMap{$0}.map{String($0)}.joined()
    }
}
