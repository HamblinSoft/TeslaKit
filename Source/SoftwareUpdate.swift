//
//  SoftwareUpdate.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/4/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public final class SoftwareUpdate: JSONDecodable {

    ///
    public enum Status: String, CustomStringConvertible, Decodable {

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
    public var installPercent: Double?

    ///
    public var downloadPercent: Double?

    ///
    public var version: String?

    ///
    public init() {}

    ///
    public init(status: Status, expectedDuration: TimeInterval?, scheduledTime: Double?, warningTimeRemaining: Double?, installPercent: Double?, downloadPercent: Double?, version: String?) {
        self.status = status
        self.expectedDuration = expectedDuration
        self.scheduledTime = scheduledTime
        self.warningTimeRemaining = warningTimeRemaining
        self.installPercent = installPercent
        self.downloadPercent = downloadPercent
        self.version = version
    }

    ///
    public init(from decoder: Decoder) throws {
        self.status = try decoder.decodeIfPresent(CodingKeys.status) ?? .noUpdate
        self.expectedDuration = try decoder.decodeIfPresent(CodingKeys.expectedDuration)
        self.scheduledTime = try decoder.decodeIfPresent(CodingKeys.scheduledTime)
        self.warningTimeRemaining = try decoder.decodeIfPresent(CodingKeys.warningTimeRemaining)
        self.installPercent = try decoder.decodeIfPresent(CodingKeys.installPercent)
        self.downloadPercent = try decoder.decodeIfPresent(CodingKeys.downloadPercent)
        self.version = try decoder.decodeIfPresent(CodingKeys.version)
    }

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case expectedDuration = "expected_duration_sec"
        case scheduledTime = "scheduled_time_ms"
        case warningTimeRemaining = "warning_time_remaining_ms"
        case installPercent = "install_perc"
        case downloadPercent = "download_perc"
        case version
    }
}

//"status" : "available",
//"install_perc" : 10,
//"download_perc" : 100,
//"expected_duration_sec" : 1500,
//"version" : "2019.32.12.2"
