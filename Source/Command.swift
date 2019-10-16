//
//  Command.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 1/10/18.
//

import Foundation

/// All commands that can be sent to a vehicle
public enum Command: CustomStringConvertible {

    /// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
    case setValetMode(SetValetModeOptions)

    /// Resets the PIN set for valet mode, if set.
    case resetValetPin(SetValetModeOptions)

    /// Opens the charge port.
    case openChargePort

    /// Closes the charge port.
    case closeChargePort

    /// Set the charge mode to standard (90% under the new percentage system introduced in 4.5).
    case setChargeLimitToStandard

    /// Set the charge mode to max range (100% under the new percentage system introduced in 4.5). Use sparingly!
    case setChargeLimitToMaxRange

    /// Set the charge limit to a custom percentage.
    case setChargeLimit(SetChargeLimitOptions)

    /// Start charging. Must be plugged in, have power available, and not have reached your charge limit.
    case startCharging

    /// Stop charging. Must already be charging.
    case stopCharging

    /// Flash the lights once.
    case flashLights

    /// Honk the horn once.
    case honkHorn

    /// Unlock the car's doors.
    case unlockDoors

    /// Lock the car's doors.
    case lockDoors

    /// Set the temperature target for the HVAC system.
    case setTemperature(SetTemperatureOptions)

    /// Start the climate control system. Will cool or heat automatically, depending on set temperature.
    case startHVAC

    /// Stop the climate control system.
    case stopHVAC

    /// Controls the car's panoramic roof, if installed.
    case movePanoRoof(MovePanoRoofOptions)

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
    case remoteStart(RemoteStartOptions)

    /// Open the trunk or frunk. Currently inoperable.
    case openTrunk(OpenTrunkOptions)

    /// Opens and closes the configured Homelink garage door of the vehicle. Keep in mind this is a toggle and the garage door state is unknown - a major limitation of Homelink
    @available(*, unavailable)
    case triggerHomelink

    ///
    @available(*, unavailable)
    case frontDefrosterOn

    ///
    @available(*, unavailable)
    case frontDefrosterOff

    ///
    @available(*, unavailable)
    case rearDefrosterOn

    ///
    @available(*, unavailable)
    case rearDefrosterOff

    // MARK: - Speed Limit

    ///
    case speedLimitActivate(SpeedLimitOptions)

    ///
    case speedLimitDeactivate(SpeedLimitOptions)

    ///
    case speedLimitClearPIN(SpeedLimitPINOptions)

    /// Set Speed Limit
    case setSpeedLimit(SpeedLimitOptions)

    // MARK: - Media Player

    ///
    case togglePlayback

    ///
    case nextTrack

    ///
    case previousTrack

    ///
    case nextFavorite

    ///
    case previousFavorite

    ///
    case volumeUp

    ///
    case volumeDown

    // MARK: - Navigation

    ///
    case navigationRequest(NavigationRequestOptions)

    // MARK: - Software Update

    ///
    case scheduleSoftwareUpdate

    ///
    case cancelSoftwareUpdate

    // MARK: - Seat/Wheel Heaters

    ///
    case remoteSeatHeater(RemoteSeatHeaterOptions)

    ///
    case remoteSteeringWheelHeater(RemoteSteeringWheelHeaterOptions)

    // MARK: - Sentry Mode

    ///
    case sentryMode(SentryModeOptions)

    case windowControl(WindowControlOptions)

    case maxDefrost

    public static let windowControlVent = Command.windowControl(WindowControlOptions(command: .vent))

    public static let windowControlClose = Command.windowControl(WindowControlOptions(command: .close))

    public var rawValue: String {
        switch self {
        case .setValetMode: return "set_valet_mode"
        case .resetValetPin: return "reset_valet_pin"
        case .openChargePort: return "charge_port_door_open"
        case .closeChargePort: return "charge_port_door_close"
        case .setChargeLimitToStandard: return "charge_standard"
        case .setChargeLimitToMaxRange: return "charge_max_range"
        case .setChargeLimit: return "set_charge_limit"
        case .startCharging: return "charge_start"
        case .stopCharging: return "charge_stop"
        case .flashLights: return "flash_lights"
        case .honkHorn: return "honk_horn"
        case .unlockDoors: return "door_unlock"
        case .lockDoors: return "door_lock"
        case .setTemperature: return "set_temps"
        case .startHVAC: return "auto_conditioning_start"
        case .stopHVAC: return "auto_conditioning_stop"
        case .movePanoRoof: return "sun_roof_control"
        case .remoteStart: return "remote_start_drive"
        case .openTrunk: return "actuate_trunk"
        case .triggerHomelink: return "trigger_homelink"
        case .frontDefrosterOn: return "front_defrost_on"
        case .frontDefrosterOff: return "front_defrost_off"
        case .rearDefrosterOn: return "rear_defrost_on"
        case .rearDefrosterOff: return "rear_defrost_off"
        case .speedLimitActivate: return "speed_limit_activate"
        case .speedLimitDeactivate: return "speed_limit_deactivate"
        case .speedLimitClearPIN: return "speed_limit_clear_pin"
        case .setSpeedLimit: return "speed_limit_set_limit"
        case .togglePlayback: return "media_toggle_playback"
        case .nextTrack: return "media_next_track"
        case .previousTrack: return "media_prev_track"
        case .nextFavorite: return "media_next_fav"
        case .previousFavorite: return "media_prev_fav"
        case .volumeUp: return "media_volume_up"
        case .volumeDown: return "media_volume_down"
        case .navigationRequest: return "navigation_request"
        case .scheduleSoftwareUpdate: return "schedule_software_update"
        case .cancelSoftwareUpdate: return "cancel_software_update"
        case .remoteSeatHeater: return "remote_seat_heater_request"
        case .remoteSteeringWheelHeater: return "remote_steering_wheel_heater_request"
        case .sentryMode: return "set_sentry_mode"
        case .windowControl: return "window_control"
        case .maxDefrost: return "set_preconditioning_max"
        }
    }

    ///
    public var description: String {
        return rawValue.replacingOccurrences(of: "_", with: " ").capitalized
    }

    ///
    public var endpoint: String {
        return "command/" + rawValue
    }
}
