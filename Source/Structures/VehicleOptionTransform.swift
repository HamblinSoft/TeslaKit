//
//  VehicleOptionTransform.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct VehicleOptionTransform: TransformType {
    
    ///
    public typealias Object = [VehicleOption]
    
    ///
    public typealias JSON = String
    
    ///
    public let separator: String

    ///
    public init(separator: String = ",") {
        self.separator = separator
    }
    
    ///
    public func transformFromJSON(_ value: Any?) -> [VehicleOption]? {
        guard let value = value as? String else { return nil }
        let codes: [String] = value.components(separatedBy: self.separator)
        let options: [VehicleOption] = codes.map{VehicleOption(code: $0)}
        return options
    }
    
    ///
    public func transformToJSON(_ value: [VehicleOption]?) -> String? {
        guard let options = value else { return nil }
        let codes: String = options.map{$0.code}.joined(separator: self.separator)
        return codes
    }
}
