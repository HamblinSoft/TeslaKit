//
//  VINTransform.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/26/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct VINTransform: TransformType {

    ///
    public typealias Object = VIN

    ///
    public typealias JSON = String

    ///
    public func transformFromJSON(_ value: Any?) -> VIN? {
        guard let value = value as? String else { return nil }
        let vin = VIN(vinString: value)
        return vin
    }

    ///
    public func transformToJSON(_ value: VIN?) -> String? {
        let vinStringOrNil: String? = value?.vinString
        return vinStringOrNil
    }
}
