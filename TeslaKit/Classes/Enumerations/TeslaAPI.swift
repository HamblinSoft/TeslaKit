//
//  TeslaAPI.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

///
public typealias TKVehicleCommandCompletion = (TKVehicleCommandResponse) -> Void

//public let teslaAPI = TeslaAPI.shared

public class TKService: Alamofire.SessionDelegate {

    ///
    public let configuration: URLSessionConfiguration

    ///
    public lazy var sessionManager: Alamofire.SessionManager! = {
        return Alamofire.SessionManager(configuration: self.configuration, delegate: self, serverTrustPolicyManager: nil)
    }()

    ///
    public init(timeout: TimeInterval = 30) {
        // Session Configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = timeout // seconds
        self.configuration = configuration
        super.init()
    }

    // MARK: - Helpers

    public func request<T: TKMappable>(_ url: URL, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, mapContext: MapContext = TKMapContext.default, completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {

        print(parameters)

        self.sessionManager.request(url, method: method, parameters: parameters, headers: headers).responseJSON { dataResponse in
            let httpResponse: HTTPURLResponse = dataResponse.response ?? HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: headers)!

            var mappedObjectOrNil: T? = nil

            if let data = dataResponse.data,
                let json = try? JSONSerialization.jsonObject(with: data),
                let object = Mapper<T>(context: mapContext).map(JSONObject: json) {
                mappedObjectOrNil = object
            }

            let request = dataResponse.request ?? (try! URLRequest(url: url, method: method, headers: headers))
            self.debugPrint(request, response: httpResponse)

            print(mappedObjectOrNil?.toJSON())

            completion(httpResponse, mappedObjectOrNil, dataResponse.error)
        }
    }

    public func clearSession(completion: @escaping () -> Void) {
        let session = self.sessionManager.session
        session.invalidateAndCancel()
        session.reset {
            self.sessionManager = nil
            completion()
        }
    }

    /// Print the contents of URLRequest and HTTPURLResponse in a consistent format that is easy to inspect
    private func debugPrint(_ request: URLRequest, response: HTTPURLResponse, responseData: Data? = nil, error: Error? = nil) {
        var components: [String] = []

        let httpResponse = response
        let statusCode = httpResponse.statusCode

        // Method/URL
        if let url = request.url {
            components.append([request.httpMethod, url.absoluteString].flatMap{$0}.joined(separator: " "))
        }

        // Request Headers
        if let headers = request.allHTTPHeaderFields, headers.keys.count > 0 {
            let headersString: String = "RequestHeaders:\n" + headers.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
            components.append(headersString)
        }

        // Request Data
        if let data = request.httpBody {
//            components.append("RequestBody:\n\(JSON(data: data))")
        }

        // Response Status
        let httpUrlResponseError = HTTPURLResponse.localizedString(forStatusCode: statusCode).capitalized
        components.append("ResponseStatus: \(response.statusCode) \(httpUrlResponseError)")

        // Response Headers
        let responseHeaders = response.allHeaderFields
        if responseHeaders.keys.count > 0 {
            let headersString: String = "ResponseHeaders:\n" + responseHeaders.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
            components.append(headersString)
        }

        // Response Data
        if let data = responseData {
//            components.append("ResponseBody:\n\(JSON(data: data))")
        }

        components.insert("", at: 0)
        components.append("")
        let logMessage = components.joined(separator: "\n")
        print(logMessage)
    }
}

fileprivate let DefaultRequestDelay: TimeInterval = 2
fileprivate let DefaultMaxAttempts: Int = 15

public class TeslaAPI {


    // MARK: - Static Properties

    public static var service = TKService()

    ///
    public static let baseURL: URL = URL(string: "https://owner-api.teslamotors.com")!

    ///
    public static let apiVersion: Int = 1

    ///
    public static let apiBaseURL: URL = baseURL.appendingPathComponent("api/\(TeslaAPI.apiVersion)")

    /// Tesla API owner api client id
    public static let ownerApiClientId: String = "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e"

    /// Tesla API owner api client secret
    public static let ownerApiClientSecret: String = "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220"


    ///
    public static var headers: HTTPHeaders = [
        "content-type": "application/json",
        "cache-control": "no-cache"
    ]

    // MARK: - Core API

    /// Performs the login. Takes in an plain text email and password, matching the owner's login information for https://my.teslamotors.com/user/login. Returns a access_token which is passed along as a header with all future requests to authenticate the user.
    public static func accessToken(email: String, password: String, completion: @escaping (HTTPURLResponse, TKAccessToken.Response?, Error?) -> Void) {
        let request = TKAccessToken.Request(grantType: "password",
                                            clientId: TeslaAPI.ownerApiClientId,
                                            clientSecret: TeslaAPI.ownerApiClientSecret,
                                            email: email,
                                            password: password)
        self.service.request(TeslaAPI.baseURL.appendingPathComponent("oauth/token"), method: HTTPMethod.post, parameters: request.toJSON(), headers: self.headers, completion: completion)
    }

    // A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.
    public static func vehicles(completion: @escaping (HTTPURLResponse, TKVehicleCollection?, Error?) -> Void) {
        self.service.request(TeslaAPI.baseURL.appendingPathComponent("vehicles"), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Get all data from vehicle
    public static func vehicleData(id: String, completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.service.request(TKDataRequest.data.url(vehicleId: id), method: HTTPMethod.get, headers: self.headers, mapContext: TKMapContext(vehicleDataMapping: true), completion: completion)
    }

    /// Get some data from the vehicle
    public static func vehicleData<T: TKDataResponse>(id: String, type: TKDataRequest, completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {
        self.service.request(type.url(vehicleId: id), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Send a command to the vehicle
    public static func send(_ command: TKCommand, to vehicleId: String, request: TKMappable? = nil, completion: @escaping TKVehicleCommandCompletion) {
        self.service.request(command.url(vehicleId: vehicleId), method: HTTPMethod.post) { (httpResponse, dataOrNil: TKVehicleCommandResponse?, errorOrNil) in
            guard let data = dataOrNil, httpResponse.statusCode == 200 else {
                completion(TKVehicleCommandResponse(result: false, reason: errorOrNil?.localizedDescription ?? HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)))
                return
            }
            guard data.result else {
                completion(TKVehicleCommandResponse(result: false, reason: data.error ?? data.reason ?? errorOrNil?.localizedDescription ?? "An error occurred"))
                return
            }
            completion(data)
        }
    }


    /// Attempt to wake the vehicle. Required for vehicle commands.
    ///
    /// - Parameters:
    ///   - context: TAContext
    ///   - completion: TKVehicleCommandCompletion
    public static func wake(vehicleId: String, completion: @escaping TKVehicleCommandCompletion) {
        var attempts: Int = 0
        var errorMessage: String?

        func doWake() {

            guard attempts < DefaultMaxAttempts else {
                completion(TKVehicleCommandResponse(result: false, reason: errorMessage ?? "An error occurred"))
                return
            }

            let requestDelay: TimeInterval = attempts == 0 ? 0 : DefaultRequestDelay

            DispatchQueue.main.asyncAfter(seconds: requestDelay) {

                self.send(.wake, to: vehicleId) { response in

                    if response.result {
                        completion(response)
                    } else {
                        errorMessage = response.error ?? response.reason ?? "An error occurred"
                        doWake()
                    }
                }

                attempts += 1
            }
        }
        doWake()
    }

    /// Attempt to wake vehicle and then issue a command. Wake command will be attempted several times over a time interval.
    ///
    /// - Parameters:
    ///   - context: TAContext
    ///   - command: TKCommand
    ///   - completion: TKVehicleCommandCompletion
    public static func wake(vehicleId: String, then command: TKCommand, completion: @escaping TKVehicleCommandCompletion) {
        self.wake(vehicleId: vehicleId) { response in
            if response.result && command != TKCommand.wake {
                self.send(command, to: vehicleId, completion: completion)
            } else {
                completion(response)
            }
        }
    }
}


// MARK: - State and Settings

/// These resources are read-only and determine the state of the vehicle's various sub-systems.
public enum TKDataRequest: String {

    /// Determines if mobile access to the vehicle is enabled.
    case mobileAccess = "mobile_enabled"

    /// Returns the state of charge in the battery.
    case chargeState = "charge_state"

    /// Returns the current temperature and climate control state.
    case climateState = "climate_state"

    /// Returns the driving and position state of the vehicle.
    case driveState = "drive_state"

    /// Returns various information about the GUI settings of the car, such as unit format and range display.
    case guiSettings = "gui_settings"

    /// Returns the vehicle's physical state, such as which doors are open.
    case vehicleState = "vehicle_state"

    ///
    case data = "data"

    ///
    public func url(vehicleId: String) -> URL {
        switch self {
        case .mobileAccess: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/\(self.rawValue)")
        case .data: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/\(self.rawValue)")
        default: return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/data_request/\(self.rawValue)")
        }
    }
}




// MARK: - Vehicle Commands

///
public enum TKCommand: String, EnumCollection {

    /// Wakes up the car from the sleep state. Necessary to get some data from the car.
    case wake = "wake_up"

    /// Sets valet mode on or off with a PIN to disable it from within the car. Reuses last PIN from previous valet session. Valet Mode limits the car's top speed to 70MPH and 80kW of acceleration power. It also disables Homelink, Bluetooth and Wifi settings, and the ability to disable mobile access to the car. It also hides your favorites, home, and work locations in navigation.
    case setValetMode = "set_valet_mode"

    /// Resets the PIN set for valet mode, if set.
    case resetValetPin = "reset_valet_pin"

    /// Opens the charge port. Does not close the charge port
    case openChargePort = "charge_port_door_open"

    /// Set the charge mode to standard (90% under the new percentage system introduced in 4.5).
    case setChargeLimitToStandard = "charge_standard"

    /// Set the charge mode to max range (100% under the new percentage system introduced in 4.5). Use sparingly!
    case setChargeLimitToMaxRange = "charge_max_range"

    /// Set the charge limit to a custom percentage.
    case setChargeLimit = "set_charge_limit"

    /// Start charging. Must be plugged in, have power available, and not have reached your charge limit.
    case startCharging = "charge_start"

    /// Stop charging. Must already be charging.
    case stopCharging = "charge_stop"

    /// Flash the lights once.
    case flashLights = "flash_lights"

    /// Honk the horn once.
    case honkHorn = "honk_horn"

    /// Unlock the car's doors.
    case unlockDoors = "door_unlock"

    /// Lock the car's doors.
    case lockDoors = "door_lock"

    /// Set the temperature target for the HVAC system.
    case setTemperature = "set_temps"

    /// Start the climate control system. Will cool or heat automatically, depending on set temperature.
    case startHVAC = "auto_conditioning_start"

    /// Stop the climate control system.
    case stopHVAC = "auto_conditioning_stop"

    /// Controls the car's panoramic roof, if installed.
    case movePanoRoof = "sun_roof_control"

    /// Start the car for keyless driving. Must start driving within 2 minutes of issuing this request.
    case remoteStart = "remote_start_drive"

    /// Open the trunk or frunk. Currently inoperable.
    //    case openTrunk = "trunk_open"

    /// Opens and closes the configured Homelink garage door of the vehicle. Keep in mind this is a toggle and the garage door state is unknown - a major limitation of Homelink
    //    case triggerHomelink = "trigger_homelink"

    ///
    //    case frontDefrosterOn = "front_defrost_on"

    ///
    //    case frontDefrosterOff = "front_defrost_off"

    ///
    //    case rearDefrosterOn = "rear_defrost_on"

    ///
    //    case rearDefrosterOff = "rear_defrost_off"

    /// Returns a readable name for the command
    public var name: String { return self.rawValue.replacingOccurrences(of: "_", with: " ").capitalized }

    /// Returns the API URL provided a vehicleId for the command
    public func url(vehicleId: String) -> URL {
        return TeslaAPI.apiBaseURL.appendingPathComponent("vehicles/\(vehicleId)/command/\(self.rawValue)")
    }

    /// Commands that can be quickliy sent
    public static let quickCommands: [TKCommand] = [.unlockDoors, .lockDoors, .flashLights, .startHVAC, .stopHVAC, .openChargePort, .setChargeLimitToStandard, .setChargeLimitToMaxRange, .startCharging, .stopCharging]
}


extension DispatchQueue {

    fileprivate func asyncAfter(seconds: Double, _ completion: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            completion()
        }
    }
}
