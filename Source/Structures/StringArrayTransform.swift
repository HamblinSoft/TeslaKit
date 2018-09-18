//
//  StringArrayTransform.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/20/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct StringArrayTransform: TransformType {

    ///
    public typealias Object = [String]

    ///
    public typealias JSON = String

    ///
    public let separator: String

    ///
    public init(separator: String) {
        self.separator = separator
    }

    ///
    public func transformFromJSON(_ value: Any?) -> [String]? {
        guard let value = value as? String else { return nil }
        let values: [String] = value.components(separatedBy: self.separator)
        return values
    }

    ///
    public func transformToJSON(_ value: [String]?) -> String? {
        guard let value = value else { return nil }
        let values: String = value.joined(separator: self.separator)
        return values
    }
}

