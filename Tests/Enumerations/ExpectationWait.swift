//
//  ExpectationWait.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

enum ExpectationWait: TimeInterval {
    case minimum = 1
    case short = 3
    case medium = 5
    case long = 10
    case max = 60

    static var `default`: ExpectationWait {
        return ExpectationWait.short
    }
}
