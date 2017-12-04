//
//  TAVehicleOptionTransform.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TAVehicleOptionTransform: TransformType {
    
    ///
    public typealias Object = [TAVehicleOption]
    
    ///
    public typealias JSON = String
    
    ///
    public let separator: String
    
    ///
    public func transformFromJSON(_ value: Any?) -> [TAVehicleOption]? {
        guard let value = value as? String else { return nil }
        let codes: [String] = value.components(separatedBy: self.separator)
        let options: [TAVehicleOption] = codes.map{TAVehicleOption(code: $0)}
        return options
    }
    
    ///
    public func transformToJSON(_ value: [TAVehicleOption]?) -> String? {
        guard let options = value else { return nil }
        let codes: String = options.map{$0.code}.joined(separator: self.separator)
        return codes
    }
}
