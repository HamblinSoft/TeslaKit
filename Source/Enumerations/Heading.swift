//
//  Heading.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/24/17.
//

import Foundation

///
public enum Heading: String, CustomStringConvertible {

    ///
    case north = "n"

    ///
    case northEast = "ne"

    ///
    case east = "e"

    ///
    case southEast = "se"

    ///
    case south = "s"

    ///
    case southWest = "sw"

    ///
    case west = "w"

    ///
    case northWest = "nw"

    ///
    public var description: String {
        switch self {
        case .north: return "North"
        case .northEast: return "North East"
        case .east: return "East"
        case .southEast: return "South East"
        case .south: return "South"
        case .southWest: return "South West"
        case .west: return "West"
        case .northWest: return "North West"
        }
    }

    public var abbreviation: String {
        return self.description.components(separatedBy: " ").map{$0.first}.compactMap{$0}.map{String($0)}.joined()
    }
}
