//
//  Vehicle.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/25/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public class Vehicle: JSONDecodable {

    /// Represents the different connection states the vehicle can be
    public enum State: String, CustomStringConvertible, Decodable {

        /// Vehicle is awake and connected to the network
        case online

        ///
        case offline

        /// Vehicle is dormant
        case asleep

        /// Returns a readable display name text for the status
        public var description: String { return rawValue.capitalized }
    }

    ///
    public var id: String = ""

    ///
    public var state: TeslaKit.Vehicle.State = .offline

    ///
    public var backseatToken: String?

    ///
    public var inService: Bool = false

    ///
    public var vin: VIN = VIN()

    ///
    public var apiVersion: Int = 0

    ///
    public var color: String?

    ///
    public var displayName: String?

    ///
    public var tokens: [String] = []

    ///
    public var backseatTokenUpdatedAt: TimeInterval?

    ///
    public var calendarEnabled: Bool = false

    ///
    public var optionCodes: [String] = []

    ///
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        state = try container.decodeIfPresent(Vehicle.State.self, forKey: .state) ?? .offline
        backseatToken = try container.decodeIfPresent(String.self, forKey: .backseatToken)
        inService = try container.decodeIfPresent(Bool.self, forKey: .inService) ?? false
        apiVersion = try container.decodeIfPresent(Int.self, forKey: .apiVersion) ?? 0
        color = try container.decodeIfPresent(String.self, forKey: .color)
        displayName = try container.decodeIfPresent(String.self, forKey: .displayName)
        tokens = try container.decodeIfPresent([String].self, forKey: .tokens) ?? []
        backseatTokenUpdatedAt = try container.decodeIfPresent(TimeInterval.self, forKey: .backseatTokenUpdatedAt)
        calendarEnabled = try container.decodeIfPresent(Bool.self, forKey: .calendarEnabled) ?? false
        optionCodes = try container.decodeIfPresent(String.self, forKey: .optionCodes)?.components(separatedBy: ",") ?? []

        do {
            var vin = VIN()
            if let vinString = try container.decodeIfPresent(String.self, forKey: .vin), let avin = VIN(vinString: vinString) {
                vin = avin
            }
            self.vin = vin
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id_s"
        case state = "state"
        case backseatToken = "backseat_token"
        case inService = "in_service"
        case vin = "vin"
        case apiVersion = "api_version"
        case color = "color"
        case displayName = "display_name"
        case tokens = "tokens"
        case backseatTokenUpdatedAt = "backseat_token_updated_at"
        case calendarEnabled = "calendar_enabled"
        case optionCodes = "option_codes"
    }
}

///
public class VehicleData: Vehicle {

    ///
    public var chargeState: ChargeState = ChargeState()

    ///
    public var climateState: ClimateState = ClimateState()

    ///
    public var guiSettings: GUISettings = GUISettings()

    ///
    public var driveState: DriveState = DriveState()

    ///
    public var vehicleState: VehicleState = VehicleState()

    ///
    public var vehicleConfig: VehicleConfig = VehicleConfig()

    ///
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        chargeState = try container.decodeIfPresent(ChargeState.self, forKey: .chargeState) ?? ChargeState()
        climateState = try container.decodeIfPresent(ClimateState.self, forKey: .climateState) ?? ClimateState()
        guiSettings = try container.decodeIfPresent(GUISettings.self, forKey: .guiSettings) ?? GUISettings()
        driveState = try container.decodeIfPresent(DriveState.self, forKey: .driveState) ?? DriveState()
        vehicleState = try container.decodeIfPresent(VehicleState.self, forKey: .vehicleState) ?? VehicleState()
        vehicleConfig = try container.decodeIfPresent(VehicleConfig.self, forKey: .vehicleConfig) ?? VehicleConfig()
    }

    private enum CodingKeys: String, CodingKey {
        case response = "response"
        case chargeState = "charge_state"
        case climateState = "climate_state"
        case guiSettings = "gui_settings"
        case driveState = "drive_state"
        case vehicleState = "vehicle_state"
        case vehicleConfig = "vehicle_config"
    }
}
