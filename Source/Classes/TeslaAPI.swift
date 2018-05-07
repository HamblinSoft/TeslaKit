//
//  TeslaAPI.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

///
public protocol TeslaAPIDelegate: class {

    ///
    func teslaApiActivityDidBegin(_ teslaAPI: TeslaAPI)

    ///
    func teslaApiActivityDidEnd(_ teslaAPI: TeslaAPI)

    ///
    func teslaApi(_ teslaAPI: TeslaAPI, didSend command: TKCommand, data: TKCommandResponse?)
}



///
open class TeslaAPI {

    ///
    public struct Configuration {

        ///
        public let baseURL: URL

        /// Tesla API owner api client id
        public let clientId: String

        /// Tesla API owner api client secret
        public let clientSecret: String

        ///
        public let apiVersion: Int = 1

        ///
        public let requestTimeout: TimeInterval

        ///
        public var apiBaseURL: URL { return self.baseURL.appendingPathComponent("api/\(self.apiVersion)") }

        ///
        public static let `default`: Configuration = Configuration(baseURL: URL(string: "https://owner-api.teslamotors.com")!,
                                                                   clientId: "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e",
                                                                   clientSecret: "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220",
                                                                   requestTimeout: 30)

        ///
        public static let mock: Configuration = Configuration(baseURL: URL(string: "https://us-central1-teslaapp-dev.cloudfunctions.net/mock")!,
                                                              clientId: "",
                                                              clientSecret: "",
                                                              requestTimeout: 10)

    }

    public let configuration: Configuration

    ///
    public var debugMode: Bool = false

    ///
    public weak var delegate: TeslaAPIDelegate? = nil

    ///
    public var session: URLSession = URLSession(configuration: .default)




    /// TODO: Consider moving this into a context
    private var headers: [String: String] = [
        "content-type": "application/json",
        "cache-control": "no-cache"
    ]





    /// Initialize a new instance of TeslaAPI
    public init(configuration: Configuration = Configuration.default, debugMode: Bool = false) {
        self.configuration = configuration
        self.debugMode = debugMode
    }




    public func request<T: TKMappable>(_ url: URL, method: String = "GET", parameters: Any? = nil, headers: [String: String] = [:], completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {

        let request: URLRequest = {
            var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: self.configuration.requestTimeout)
            request.httpMethod = method
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
            if let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            }
            return request
        }()

        let task = self.session.dataTask(with: request) { (dataOrNil, responseOrNil, errorOrNil) in

            self.delegate?.teslaApiActivityDidEnd(self)

            let response: HTTPURLResponse = (responseOrNil as? HTTPURLResponse) ?? HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: headers)!

            var mappedData: T? = nil

            if self.debugMode {
                self.debugPrint(request, response: response, responseData: dataOrNil, error: errorOrNil)
            }

            do {
                if let data = dataOrNil {
                    let json: Any = try JSONSerialization.jsonObject(with: data)
                    mappedData = Mapper<T>().map(JSONObject: json)
                }
            } catch let error {
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
                completion(response, mappedData, errorOrNil)
            }
        }

        self.delegate?.teslaApiActivityDidBegin(self)
        task.resume()
    }




    /// Set the accessToken to be used with all requests
    ///
    /// - Parameter accessToken: String
    public func setAccessToken(_ accessToken: String?) {
        if let accessToken = accessToken {
            self.headers["Authorization"] = "Bearer " + accessToken
        } else {
            self.headers["Authorization"] = nil
        }
    }












    // MARK: - Core API


    /// Performs the login. Takes in an plain text email and password, matching the owner's login information for https://my.teslamotors.com/user/login. Returns a access_token which is passed along as a header with all future requests to authenticate the user.
    ///
    /// - Parameters:
    ///   - email: The email of the user
    ///   - password: The password of the user
    ///   - completion: Completion Handler
    open func accessToken(email: String, password: String, completion: @escaping (HTTPURLResponse, TKAccessToken.Response?, Error?) -> Void) {
        let request = TKAccessToken.Request(grantType: "password",
                                            clientId: self.configuration.clientId,
                                            clientSecret: self.configuration.clientSecret,
                                            email: email,
                                            password: password)


        self.request(self.configuration.baseURL.appendingPathComponent("oauth/token"),
                     method: "POST",
                     parameters: request.toJSON(),
                     headers: self.headers,
                     completion: completion)
    }

//    open func refreshToken(_ refreshToken: String, completion: @escaping (HTTPURLResponse, TKAccessToken.Response?, Error?) -> Void) {
//        let request = TKAccessToken.Request(grantType: "refresh_token",
//                                            clientId: self.configuration.clientId,
//                                            clientSecret: self.configuration.clientSecret,
//                                            refreshToken)
//
//
//        self.request(self.configuration.baseURL.appendingPathComponent("oauth/token"),
//                     method: "POST",
//                     parameters: request.toJSON(),
//                     headers: self.headers,
//                     completion: completion)
//    }

    open func revokeAccessToken() {
        /**
         * Logout and invalidate the current auth token
         * @param {string} authToken - Tesla provided OAuth token
         * @param {nodeBack} callback - Node-style callback
         */
//        exports.logout = function logout(authToken, callback) {
//            log(API_CALL_LEVEL, "TeslaJS.logout()");
//
//            callback = callback || function (err, result) { /* do nothing! */ }
//
//            request({
//                method: 'POST',
//                url: portalBaseURI + '/oauth/revoke',
//                headers: { Authorization: "Bearer " + authToken, 'Content-Type': 'application/json; charset=utf-8' }
//            }, function (error, response, body) {
//
//                callback(error, { error: error, response: response, body: body });
//
//                log(API_RETURN_LEVEL, "TeslaJS.logout() completed.");
//            });
//        }
    }

    open func setCalendarEntry() {

//        /**
//         * Set a calendar entry
//         * @param {optionsType} options - options object
//         * @param {object} entry - calendar entry object
//         * @param {nodeBack} callback - Node-style callback
//         * @returns {object} result
//         */
//        exports.calendar = function calendar(options, entry, callback) {
//            post_command(options, "command/upcoming_calendar_entries", entry, callback);
//        }
//
//        /**
//         * @function calendarAsync
//         * @param {optionsType} options - options object
//         * @param {object} entry - calendar entry object
//         * @returns {Promise} result
//         */
//        exports.calendarAsync = Promise.denodeify(exports.calendar);
//
//        /**
//         * Create a calendar entry
//         * @param {string} eventName - name of the event
//         * @param {string} location - location of the event
//         * @param {number} startTime - Javascript timestamp for start of event
//         * @param {number} endTime - Javascript timestamp for end of event
//         * @param {string} accountName - name of the calendar account
//         * @param {string} phoneName - phone bluetooth name
//         * @returns {object} result
//         */
//        exports.makeCalendarEntry = function makeCalendarEntry(eventName, location, startTime, endTime, accountName, phoneName) {
//            var entry = {
//                "calendar_data": {
//                    "access_disabled": false,
//                    "calendars": [
//                    {
//                    "color": "ff9a9cff",
//                    "events": [
//                    {
//                    "allday": false,
//                    "color": "ff9a9cff",
//                    "end": endTime || new Date().getTime(),
//                    "start": startTime || new Date().getTime(),
//                    "cancelled": false,
//                    "tentative": false,
//                    "location": location || "",
//                    "name": eventName || "Event name",
//                    "organizer": ""
//                    }
//                    ],
//                    "name": accountName || ""    // calendar account name?
//                    }
//                    ],
//                    "phone_name": phoneName,    // Bluetooth name of phone
//                    "uuid": "333239059961778"   // any random value OK?
//                }
//            };
//
//            return entry;
//        }
    }

    open func triggerHomelink() {
        /**
         * Trigger homelink
         * @param {optionsType} options - options object
         * @param {number} lat - vehicle GPS latitude
         * @param {number} long - vehicle GPS longitude
         * @param {string} string - one of the tokens from vehicle JSON
         * @param {nodeBack} callback - Node-style callback
         * @returns {object} result
         */
//        exports.homelink = function homelink(options, lat, long, token, callback) {
//            post_command(options, "command/trigger_homelink", { lat: lat, long: long, token: token } , callback);
//        }
    }


    /// A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.
    ///
    /// - Parameter completion: Completion Handler
    open func vehicles(completion: @escaping (HTTPURLResponse, TKVehicleCollection?, Error?) -> Void) {
        self.request(self.configuration.apiBaseURL.appendingPathComponent("vehicles"),
                     method: "GET",
                     headers: self.headers,
                     completion: completion)
    }

    /// Get all data from the vehicle
    ///
    /// - Parameters:
    ///   - vehicle: The vehicle to obtain data from
    ///   - completion: Completion Handler
    open func data(for vehicle: TKVehicle, completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/\(TKDataRequest.data.rawValue)"),
                     method: "GET",
                     headers: self.headers,
                     completion: completion)
    }


    /// Get some data from the vehicle
    ///
    /// - Parameters:
    ///   - vehicle: The vehicle to obtain data from
    ///   - type: The type of data to request
    ///   - completion: Completion Handler
    open func data<T: TKDataResponse>(for vehicle: TKVehicle, type: TKDataRequest, completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {

        let url: URL = {
            switch type {
            case .mobileAccess: return self.configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/\(TKDataRequest.mobileAccess.rawValue)")
            case .data: return self.configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/\(TKDataRequest.data.rawValue)")
            default: return self.configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/data_request/\(type.rawValue)")
            }
        }()

        self.request(url,
                     method: "GET",
                     headers: self.headers,
                     completion: completion)
    }


    /// Send a command to the vehicle
    ///
    /// - Parameters:
    ///   - command: The command to be sent
    ///   - vehicle: The vehicle to send the command to
    ///   - request: Optional data to be included with the command
    ///   - completion: Completion Handler
    open func send(_ command: TKCommand, to vehicle: TKVehicle, parameters: TKMappable? = nil, completion: @escaping (TKCommandResponse) -> Void) {

        let url = self.configuration.apiBaseURL.appendingPathComponent("vehicles/\(vehicle.id)/command/\(command.rawValue)")

        self.request(url,
                     method: "POST",
                     parameters: parameters?.toJSON(),
                     headers: self.headers) { (httpResponse, dataOrNil: TKCommandResponse?, errorOrNil) in

                        defer {
                            self.delegate?.teslaApi(self, didSend: command, data: dataOrNil)
                        }

                        guard let data = dataOrNil, httpResponse.statusCode == 200 else {
                            completion(TKCommandResponse(result: false, reason: errorOrNil?.localizedDescription ?? HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)))
                            return
                        }

                        guard data.result else {
                            completion(TKCommandResponse(result: false, reason: data.error ?? data.reason ?? errorOrNil?.localizedDescription ?? "An error occurred"))
                            return
                        }

                        completion(data)
        }
    }

    ///
    open func clearSession(completion: @escaping () -> Void) {
        let session = self.session
        session.invalidateAndCancel()
        session.reset {
            self.session = URLSession(configuration: .default)
            completion()
        }
    }

    /// Returns a list of products, i.e. Powerwall
    internal func products(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.apiBaseURL.appendingPathComponent("products"),
                     headers: self.headers,
                     completion: completion)
    }

    internal func batterySOC(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.baseURL.appendingPathComponent("api/system_status/soe"),
                     headers: self.headers,
                     completion: completion)
    }

    internal func meterAggregates(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.baseURL.appendingPathComponent("api/meters/aggregates"),
                     headers: self.headers,
                     completion: completion)
    }

    internal func powerWalls(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.baseURL.appendingPathComponent("api/powerwalls"),
                     headers: self.headers,
                     completion: completion)
    }

    internal func connectionStatus(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.baseURL.appendingPathComponent("api/sitemaster"),
                     headers: self.headers,
                     completion: completion)
    }

    internal func versionStatus(completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.request(self.configuration.baseURL.appendingPathComponent("api/status"),
                     headers: self.headers,
                     completion: completion)
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

    fileprivate func asyncAfter(seconds: Double, _ completion: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            completion()
        }
    }
}

fileprivate func prettyPrint(json data: Data) throws -> String {
    let json = try JSONSerialization.jsonObject(with: data)
    let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    let string = String(data: data, encoding: String.Encoding.utf8)
    return string ?? ""
}
