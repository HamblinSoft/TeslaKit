//
//  TeslaAPI.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation

///
public protocol TeslaAPIDelegate: class {

    ///
    func teslaApiActivityDidBegin(_ teslaAPI: TeslaAPI)

    ///
    func teslaApiActivityDidEnd(_ teslaAPI: TeslaAPI, response: HTTPURLResponse, error: Error?)

    ///
    func teslaApi(_ teslaAPI: TeslaAPI, didSend command: Command, data: CommandResponse?, result: CommandResponse)
}


///
open class TeslaAPI: NSObject, URLSessionDelegate {

    ///
    public struct Configuration {

        ///
        public let baseURL: URL

        /// Tesla API owner api client id
        public let clientId: String

        /// Tesla API owner api client secret
        public let clientSecret: String

        ///
        public let apiVersion: Int

        ///
        public let requestTimeout: TimeInterval

        ///
        public init(baseURL: URL, clientId: String, clientSecret: String, apiVersion: Int, requestTimeout: TimeInterval) {
            self.baseURL = baseURL
            self.clientId = clientId
            self.clientSecret = clientSecret
            self.apiVersion = apiVersion
            self.requestTimeout = requestTimeout
        }

        ///
        public var apiBaseURL: URL { return baseURL.appendingPathComponent("api/\(apiVersion)") }

        ///
        public static let `default`: Configuration = Configuration(baseURL: URL(string: "https://owner-api.teslamotors.com")!,
                                                                   clientId: "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
                                                                   clientSecret: "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220",
                                                                   apiVersion: 1,
                                                                   requestTimeout: 30)

        ///
        public static let mock: Configuration = Configuration(baseURL: URL(string: "https://us-central1-teslaapp-dev.cloudfunctions.net/mock")!,
                                                              clientId: "",
                                                              clientSecret: "",
                                                              apiVersion: 1,
                                                              requestTimeout: 10)

    }

    ///
    public let configuration: Configuration

    ///
    public var debugMode: Bool = false

    ///
    public weak var delegate: TeslaAPIDelegate? = nil

    ///
    public private(set) var session: URLSession

    ///
    public var headers: [String: String] = [
        "content-type": "application/json",
        "cache-control": "no-cache"
    ]

    /// Initialize a new instance of TeslaAPI
    public init(configuration: Configuration = .default, session: URLSession = URLSession(configuration: .default), debugMode: Bool = false) {
        self.configuration = configuration
        self.debugMode = debugMode
        self.session = session
    }

    ///
    private func request<T: Encodable, U: JSONDecodable>(_ url: URL, method: HTTPMethod = .get, httpBody: T? = nil, headers: [String: String] = [:], completion: @escaping (HTTPResponse<U>) -> Void) {
        let encoder = JSONEncoder()
        let encodedHttpBody = try? encoder.encode(httpBody)
        request(url, method: method, httpBody: encodedHttpBody, headers: headers, completion: completion)
    }

    ///
    private func request<T: JSONDecodable>(_ url: URL, method: HTTPMethod = .get, httpBody: Data? = nil, headers: [String: String] = [:], completion: @escaping (HTTPResponse<T>) -> Void) {

        request(url, method: method, httpBody: httpBody, headers: headers) { (response, data, error) in

            func decodeData(data: Data?) throws -> T? {
                guard let data = data else { return nil }
                return try JSONDecoder().decode(T.self, from: data)
            }

            do {
                let object: T? = try decodeData(data: data)
                completion(HTTPResponse(httpResponse: response, data: object, rawData: data, error: error))
            } catch {
                completion(HTTPResponse(httpResponse: response, data: nil, rawData: data, error: error))
            }
        }
    }

    ///
    private func request(_ url: URL, method: HTTPMethod, httpBody: Data?, headers: [String: String], completion: @escaping (HTTPURLResponse, Data?, Error?) -> Void) {

        // Create the request
        let request: URLRequest = {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: configuration.requestTimeout)
            request.httpMethod = method.rawValue
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
            request.httpBody = httpBody
            return request
        }()

        // Create the task
        let task = session.dataTask(with: request) { [weak self] (dataOrNil, responseOrNil, errorOrNil) in

            guard let self = self else { return }

            let response: HTTPURLResponse = (responseOrNil as? HTTPURLResponse) ?? HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: headers)!

            self.delegate?.teslaApiActivityDidEnd(self, response: response, error: errorOrNil)

            // If debug mode, print out contents of response
            if self.debugMode {
                self.debugPrint(request, response: response, responseData: dataOrNil, error: errorOrNil)
            }

            // Call the completion handler
            DispatchQueue.main.async {

                completion(response, dataOrNil, errorOrNil)
            }
        }

        delegate?.teslaApiActivityDidBegin(self)

        // Start the task immediately
        task.resume()
    }

    // MARK: - Authentication

    ///
    open func getAccessToken(email: String, password: String, completion: @escaping (_ response: HTTPResponse<AccessToken.Response>) -> Void) {
        request(configuration.baseURL.appendingPathComponent("oauth/token"),
                method: .post,
                httpBody: AccessToken.Request(grantType: "password",
                                              clientId: configuration.clientId,
                                              clientSecret: configuration.clientSecret,
                                              email: email,
                                              password: password),
                headers: headers,
                completion: completion)
    }

    /// Request a new access token using a refresh token
    open func getRefreshToken(_ refreshToken: String, completion: @escaping (_ response: HTTPResponse<RefreshToken.Response>) -> Void) {
        request(configuration.baseURL.appendingPathComponent("oauth/token"),
                method: .post,
                httpBody: RefreshToken.Request(grantType: "refresh_token",
                                               clientId: configuration.clientId,
                                               clientSecret: configuration.clientSecret,
                                               refreshToken: refreshToken),
                headers: headers,
                completion: completion)
    }

    // Logout and invalidate the current auth token
    open func revokeAccessToken(completion: @escaping (_ response: HTTPResponse<AccessToken.Response>) -> Void) {
        request(configuration.baseURL.appendingPathComponent("oauth/revoke"),
                method: .post,
                httpBody: nil,
                headers: headers,
                completion: completion)
    }

    /// Set the accessToken to be used with all requests
    open func setAccessToken(_ accessToken: String?) {
        headers["Authorization"] = {
            if let accessToken = accessToken {
                return "Bearer " + accessToken
            }
            return nil
        }()
    }

    ///
    open func reset(completion: @escaping () -> Void) {
        let session = self.session
        session.invalidateAndCancel()
        session.reset {
            self.session = URLSession(configuration: .default)
            completion()
        }
    }

    // MARK: - Vehicle List

    ///
    open func vehicles(_ completion: @escaping (_ response: HTTPResponse<VehicleList>) -> Void) {
        request(configuration.apiBaseURL.appendingPathComponent("vehicles"),
                method: .get,
                httpBody: nil,
                headers: headers,
                completion: completion)
    }

    // MARK: - Wake Vehicle

    ///
    internal func wake(_ vehicle: Vehicle, completion: @escaping (_ response: HTTPResponse<WakeResponse>) -> Void) {
        request(configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/wake_up"),
                method: .post,
                httpBody: nil,
                headers: headers,
                completion: completion)
    }

    ///
    open func wake(_ vehicle: Vehicle, completion: @escaping (_ result: Bool, _ response: HTTPResponse<WakeResponse>) -> Void) {
        wake(vehicle) { (response: HTTPResponse<WakeResponse>) in
            completion(response.data?.state == .online, response)
        }
    }

    ///
    open func forceWake(_ vehicle: Vehicle, delay: TimeInterval = 3.0, attempts: Int = 10, completion: @escaping (_ result: Bool, _ response: HTTPResponse<WakeResponse>) -> Void) {

        var numberOfAttempts: Int = 0

        func attemptWakeCompletionHandler(result: Bool, httpResponse: HTTPResponse<WakeResponse>) {
            if result {
                // Wake was successful
                completion(true, httpResponse)

            } else if numberOfAttempts >= attempts {

                // Reached the max number of retries
                completion(false, httpResponse)

            } else {

                // Retry again
                numberOfAttempts += 1

                DispatchQueue.main.async(wait: delay) {
                    attemptWake(attemptWakeCompletionHandler)
                }
            }
        }

        func attemptWake(_ completion: @escaping (Bool, HTTPResponse<WakeResponse>) -> Void) {
            wake(vehicle, completion: completion)
        }

        attemptWake(attemptWakeCompletionHandler)
    }

    // MARK: - Vehicle Data

    /// Get all data from the vehicle
    open func getData(for vehicle: Vehicle, completion: @escaping (_ response: HTTPResponse<VehicleData>) -> Void) {
        request(configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/data"),
                method: .get,
                httpBody: nil,
                headers: headers,
                completion: completion)
    }

    ///
    @available(*, unavailable)
    open func getDataIfAwake(for vehicle: Vehicle, completion: @escaping (_ response: HTTPResponse<VehicleData>) -> Void) {

        vehicles { res in

            guard let vehicle = res.data?.vehicles.filter({$0 == vehicle}).first, vehicle.state == .online else {
                completion(HTTPResponse(httpResponse: HTTPURLResponse(), data: nil, rawData: nil, error: nil))
                return
            }

            self.getData(for: vehicle, completion: completion)
        }
    }

    ///
    open func forceWakeAndGetData(for vehicle: Vehicle, delay: TimeInterval = 3.0, attempts: Int = 10, completion: @escaping (_ response: HTTPResponse<VehicleData>) -> Void) {
        forceWake(vehicle) { (result, response) in
            self.getData(for: vehicle, completion: completion)
        }
    }

    // MARK: - Mobile Access

    ///
    open func mobileAccess(for vehicle: Vehicle, completion: @escaping (_ response: HTTPResponse<MobileAccess>) -> Void) {
        request(configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/mobile_enabled"),
                method: .get,
                httpBody: nil,
                headers: headers,
                completion: completion)
    }

    // MARK: - Send Commands

    ///
    open func send(_ command: Command, to vehicle: Vehicle, completion: @escaping (CommandResponse) -> Void) {

        let httpBody: Data? = {
            let encoder = JSONEncoder()

            switch command {
            case .setValetMode(let options):
                return try? encoder.encode(options)
            case .resetValetPin(let options):
                return try? encoder.encode(options)
            case .openChargePort:
                return nil
            case .closeChargePort:
                return nil
            case .setChargeLimitToStandard:
                return nil
            case .setChargeLimitToMaxRange:
                return nil
            case .setChargeLimit(let options):
                return try? encoder.encode(options)
            case .startCharging:
                return nil
            case .stopCharging:
                return nil
            case .flashLights:
                return nil
            case .honkHorn:
                return nil
            case .unlockDoors:
                return nil
            case .lockDoors:
                return nil
            case .setTemperature(let options):
                return try? encoder.encode(options)
            case .startHVAC:
                return nil
            case .stopHVAC:
                return nil
            case .movePanoRoof(let options):
                return try? encoder.encode(options)
            case .remoteStart(let options):
                return try? encoder.encode(options)
            case .openTrunk(let options):
                return try? encoder.encode(options)
            case .speedLimitActivate(let options):
                return try? encoder.encode(options)
            case .speedLimitDeactivate(let options):
                return try? encoder.encode(options)
            case .speedLimitClearPIN(let options):
                return try? encoder.encode(options)
            case .setSpeedLimit(let options):
                return try? encoder.encode(options)
            case .togglePlayback:
                return nil
            case .nextTrack:
                return nil
            case .previousTrack:
                return nil
            case .nextFavorite:
                return nil
            case .previousFavorite:
                return nil
            case .volumeUp:
                return nil
            case .volumeDown:
                return nil
            case .navigationRequest(let options):
                return try? encoder.encode(options)
            case .scheduleSoftwareUpdate:
                return nil
            case .cancelSoftwareUpdate:
                return nil
            case .remoteSeatHeater(let options):
                return try? encoder.encode(options)
            case .remoteSteeringWheelHeater(let options):
                return try? encoder.encode(options)
            case .sentryMode(let options):
                return try? encoder.encode(options)
            case .windowControl(let options):
                return try? encoder.encode(options)
            case .maxDefrost:
                return nil
            }
        }()

        let url = configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/\(command.endpoint)")

        request(url,
                method: .post,
                httpBody: httpBody,
                headers: headers) { (res: HTTPResponse<CommandResponse>) in

                    guard let data = res.data, res.statusCode == 200 else {
                        completion(CommandResponse(result: false, reason: res.localizedStatusCodeDescription))
                        return
                    }

                    completion(data)
        }
    }

    // MARK: - Nearby Charging Sites

    /// Returns destination and supercharger locations near the specified vehicle
    open func chargingSites(near vehicle: Vehicle, completion: @escaping (_ response: HTTPResponse<NearbyChargingSites>) -> Void) {
        request(configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/nearby_charging_sites"),
            method: .get,
            httpBody: nil,
            headers: headers,
            completion: completion)
    }

    // MARK: - Debug

    /// Print the contents of URLRequest and HTTPURLResponse in a consistent format that is easy to inspect
    private func debugPrint(_ request: URLRequest, response: HTTPURLResponse, responseData: Data? = nil, error: Error? = nil) {
        var components: [String] = []

        let httpResponse = response
        let statusCode = httpResponse.statusCode

        // Method/URL
        if let url = request.url {
            components.append([request.httpMethod, url.absoluteString].compactMap{$0}.joined(separator: " "))
        }

        // Request Headers
        if let headers = request.allHTTPHeaderFields, headers.keys.count > 0 {
            let headersString: String = "RequestHeaders:\n" + headers.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
            components.append(headersString)
        }

        // Request Data
        if let data = request.httpBody, let json = try? prettyPrint(json: data) {
            components.append("RequestBody:\n\(json)")
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
        if let data = responseData, let json = try? prettyPrint(json: data) {
            components.append("ResponseBody:\n\(json)")
        }

        components.insert("", at: 0)
        components.append("")
        let logMessage = components.joined(separator: "\n")
        print(logMessage)
    }
}

extension DispatchQueue {

    ///
    fileprivate func async(wait seconds: TimeInterval, _ completion: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            completion()
        }
    }
}

///
internal func prettyPrint(json data: Data) throws -> String {
    let json = try JSONSerialization.jsonObject(with: data)
    let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let string = String(data: data, encoding: String.Encoding.utf8)
    return string ?? ""
}

///
public class WakeResponse: JSONDecodable, Equatable {

    ///
    public static func ==(lhs: WakeResponse, rhs: WakeResponse) -> Bool {
        return lhs.id == rhs.id
    }

    ///
    public var id: String = ""

    ///
    public var state: TeslaKit.Vehicle.State = .offline

    ///
    public var inService: Bool = false

    ///
    public init(id: String, state: TeslaKit.Vehicle.State, inService: Bool) {
        self.id = id
        self.state = state
        self.inService = inService
    }

    ///
    public required init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        state = try container.decodeIfPresent(Vehicle.State.self, forKey: .state) ?? .offline
        inService = try container.decodeIfPresent(Bool.self, forKey: .inService) ?? false
    }

    private enum CodingKeys: String, CodingKey {
        case response = "response"
        case id = "id_s"
        case state = "state"
        case inService = "in_service"
    }
}
