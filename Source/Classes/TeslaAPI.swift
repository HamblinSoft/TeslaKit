//
//  TeslaAPI.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol TeslaAPIDelegate: class {

    ///
    func teslaApiActivityDidBegin(_ teslaAPI: TeslaAPI)

    ///
    func teslaApiActivityDidEnd(_ teslaAPI: TeslaAPI)

    ///
    func teslaApi(_ teslaAPI: TeslaAPI, didSend command: TKCommand, data: TKCommandResponse?)
}


open class TeslaAPI {




    // MARK: - Static Properties


    /// API version
    public static let apiVersion: Int = 1

    /// Base owner API URL
    public static let baseURL: URL = URL(string: "https://owner-api.teslamotors.com")!

    /// Base owner API URL with api version
    public static let apiBaseURL: URL = baseURL.appendingPathComponent("api/\(TeslaAPI.apiVersion)")

    /// Tesla API owner api client id
    public let ownerApiClientId: String

    /// Tesla API owner api client secret
    public let ownerApiClientSecret: String

    ///
    public let requestTimeout: TimeInterval

    ///
    public var debugMode: Bool = false

    ///
    public weak var delegate: TeslaAPIDelegate? = nil

    ///
    //    private let configuration: URLSessionConfiguration

    ///
    public var session: URLSession = URLSession(configuration: .default)




    /// TODO: Consider moving this into a context
    private var headers: [String: String] = [
        "content-type": "application/json",
        "cache-control": "no-cache"
    ]






    /// Initialize a new instance of TeslaAPI
    public init(ownerApiClientId: String, ownerApiClientSecret: String, requestTimeout: TimeInterval = 30, debugMode: Bool = false) {
        self.ownerApiClientId = ownerApiClientId
        self.ownerApiClientSecret = ownerApiClientSecret
        self.requestTimeout = requestTimeout
        self.debugMode = debugMode
    }




    public func request<T: TKMappable>(_ url: URL, method: String = "GET", parameters: Any? = nil, headers: [String: String] = [:], completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {

        let request: URLRequest = {
            var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: self.requestTimeout)
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
                                            clientId: self.ownerApiClientId,
                                            clientSecret: self.ownerApiClientSecret,
                                            email: email,
                                            password: password)


        self.request(TeslaAPI.baseURL.appendingPathComponent("oauth/token"),
                     method: "POST",
                     parameters: request.toJSON(),
                     headers: self.headers,
                     completion: completion)
    }


    /// A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.
    ///
    /// - Parameter completion: Completion Handler
    open func vehicles(completion: @escaping (HTTPURLResponse, TKVehicleCollection?, Error?) -> Void) {
        self.request(TeslaAPI.apiBaseURL.appendingPathComponent("vehicles"),
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
        self.request(TKDataRequest.data.url(vehicleId: vehicle.id),
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
        self.request(type.url(vehicleId: vehicle.id),
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
    open func send(_ command: TKCommand, to vehicle: TKVehicle, request: TKMappable? = nil, completion: @escaping (TKCommandResponse) -> Void) {
        self.request(command.url(vehicleId: vehicle.id),
                     method: "POST",
                     parameters: request?.toJSON(),
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
