//
//  VehicleUpdater.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 5/28/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation
import TeslaKit

///
public class VehicleUpdater {

    ///
    public static let didUpdateNotification = Notification.Name(rawValue: "VehicleUpdater.didUpdateNotification")

    ///
    public struct Configuration {

        ///
        public static let `default` = Configuration(interval: 3, wakeVehicle: false)

        ///
        public let interval: TimeInterval

        ///
        public let wakeVehicle: Bool

        ///
        public init(interval: TimeInterval, wakeVehicle: Bool) {
            self.interval = interval
            self.wakeVehicle = wakeVehicle
        }
    }

    ///
    public let teslaAPI: TeslaAPI

    ///
    public let configuration: Configuration

    ///
    public private(set) var isRunning: Bool = false

    ///
    private var isUpdating: Bool = false

    ///
    private var vehicle: Vehicle?

    ///
    public private(set) var vehicleData: Vehicle = Vehicle(id: "")

    ///
    private var timer = Timer()

    ///
    public init(teslaAPI: TeslaAPI, configuration: Configuration = .default) {
        self.teslaAPI = teslaAPI
        self.configuration = configuration
    }

    ///
    public func setVehicle(_ vehicle: Vehicle) {
        self.vehicle = vehicle
    }

    ///
    public func startUpdating() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(timeInterval: configuration.interval, target: self, selector: #selector(timerIntervalAction), userInfo: nil, repeats: true)
        timer.fire()
    }

    ///
    public func stopUpdating() {
        timer.invalidate()
        timer = Timer()
        isRunning = false
    }

    ///
    @objc private func timerIntervalAction() {
        guard !isUpdating else { return }
        isUpdating = true

        let teslaAPI = self.teslaAPI

        guard let vehicle = vehicle else {
            return
        }

        func getData() {
            teslaAPI.getData(for: vehicle) { res in

                guard self.isRunning else { return }

                if let vehicle = res.data, vehicle.id == self.vehicle?.id {
                    self.vehicleData = vehicle
                    NotificationCenter.default.post(name: VehicleUpdater.didUpdateNotification, object: self)
                }

                self.isUpdating = false
            }
        }

        if configuration.wakeVehicle {

            teslaAPI.wake(vehicle) { (isAwake, res) in
                
            }

        } else {

            getData()
        }
    }
}
