//
//  VehicleUpdater.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 5/28/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation

///
@available(*, unavailable)
public class VehicleUpdater {

    ///
    public static let didUpdateNotification = Notification.Name(rawValue: "VehicleUpdater.didUpdateNotification")

    ///
    public struct Configuration {

        ///
        public static let `default` = Configuration(interval: 3, delay: 1)

        ///
        public let interval: TimeInterval

        ///
        public let delay: TimeInterval

        ///
        public init(interval: TimeInterval, delay: TimeInterval) {
            self.interval = interval
            self.delay = delay
        }
    }

    ///
    private let vehicleId: String

    ///
    public let teslaAPI: TeslaAPI

    ///
    public let configuration: Configuration

    ///
    public private(set) var isRunning: Bool = false

    ///
    public private(set) var vehicleData: Vehicle?

    ///
    public init(vehicleId: String, teslaAPI: TeslaAPI, configuration: Configuration = .default) {
        self.vehicleId = vehicleId
        self.teslaAPI = teslaAPI
        self.configuration = configuration
    }

    ///
    public func startUpdating() {
        isRunning = true
    }
}
