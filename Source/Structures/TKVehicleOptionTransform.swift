//
//  TKVehicleOptionTransform.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/24/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct TKVehicleOptionTransform: TransformType {
    
    ///
    public typealias Object = [TKVehicleOption]
    
    ///
    public typealias JSON = String
    
    ///
    public let separator: String
    
    ///
    public func transformFromJSON(_ value: Any?) -> [TKVehicleOption]? {
        guard let value = value as? String else { return nil }
        let codes: [String] = value.components(separatedBy: self.separator)
        let options: [TKVehicleOption] = codes.map{TKVehicleOption(code: $0)}
        return options
    }
    
    ///
    public func transformToJSON(_ value: [TKVehicleOption]?) -> String? {
        guard let options = value else { return nil }
        let codes: String = options.map{$0.code}.joined(separator: self.separator)
        return codes
    }
}
