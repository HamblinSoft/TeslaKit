//
//  SoftwareUpdate.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public struct SoftwareUpdate: TKMappable {

    ///
    public enum Status: String, CustomStringConvertible {

        /// No software update available
        case noUpdate = ""

        /// A software update is available
        case available = "available"

        /// A software update is scheduled
        case scheduled = "scheduled"

        ///
        case installing = "installing"

        ///
        public var description: String {
            switch self {
            case .noUpdate: return "No Update"
            case .available: return "Update Available"
            case .scheduled: return "Update Scheduled"
            case .installing: return "Installing"
            }
        }
    }

    ///
    public var status: Status = Status.noUpdate

    /// The expected amount of time required to complete the software update (in seconds).
    /// Example Value: 6000
    /// This means the software update is expected to take 1 hr and 40 min to complete.
    public var expectedDuration: TimeInterval?

    /// The time the software update is scheduled for (in milliseconds).
    public var scheduledTime: Double?

    /// The amount of time the warning message will remain on the screen in the car until the software update begins (in milliseconds). User can cancel the software update until this time runs out.
    public var warningTimeRemaining: Double?

    ///
    public init(status: Status, expectedDuration: TimeInterval?, scheduledTime: Double?, warningTimeRemaining: Double?) {
        self.status = status
        self.expectedDuration = expectedDuration
        self.scheduledTime = scheduledTime
        self.warningTimeRemaining = warningTimeRemaining
    }

    ///
    public init() {}

    ///
    public mutating func mapping(map: Map) {
        status <- (map["status"], EnumTransform())
        expectedDuration <- map["expected_duration_sec"]
        scheduledTime <- map["scheduled_time_ms"]
        warningTimeRemaining <- map["warning_time_remaining_ms"]
    }
}
