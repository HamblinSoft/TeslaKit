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

fileprivate let DefaultRequestDelay: TimeInterval = 2
fileprivate let DefaultMaxAttempts: Int = 15

public class TeslaAPI {


    // MARK: - Static Properties

    /// Base owner API URL
    public static let baseURL: URL = URL(string: "https://owner-api.teslamotors.com")!

    /// API version
    public static let apiVersion: Int = 1

    /// Base owner API URL with api version
    public static let apiBaseURL: URL = baseURL.appendingPathComponent("api/\(TeslaAPI.apiVersion)")

    /// Tesla API owner api client id
    public static let ownerApiClientId: String = "e4a9949fcfa04068f59abb5a658f2bac0a3428e4652315490b659d5ab3f35a9e"

    /// Tesla API owner api client secret
    public static let ownerApiClientSecret: String = "c75f14bbadc8bee3a7594412c31416f8300256d7668ea7e6e7f06727bfb9d220"

    /// HTTPClient used to make network requests
    public let httpClient: TKHTTPClient


    // TODO: Consider moving this into a context
    private var headers: HTTPHeaders = [
        "content-type": "application/json",
        "cache-control": "no-cache"
    ]

    ///
    public init(httpClient: TKHTTPClient = TKHTTPClient(timeout: 30)) {
        self.httpClient = httpClient
    }

    // Set the accessToken to be used for requests
    public func setAccessToken(_ accessToken: String?) {
        if let accessToken = accessToken {
            self.headers["Authorization"] = "Bearer " + accessToken
        } else {
            self.headers["Authorization"] = nil
        }
    }

    // MARK: - Core API

    /// Performs the login. Takes in an plain text email and password, matching the owner's login information for https://my.teslamotors.com/user/login. Returns a access_token which is passed along as a header with all future requests to authenticate the user.
    public func accessToken(email: String, password: String, completion: @escaping (HTTPURLResponse, TKAccessToken.Response?, Error?) -> Void) {
        let request = TKAccessToken.Request(grantType: "password",
                                            clientId: TeslaAPI.ownerApiClientId,
                                            clientSecret: TeslaAPI.ownerApiClientSecret,
                                            email: email,
                                            password: password)
        self.httpClient.request(TeslaAPI.baseURL.appendingPathComponent("oauth/token"), method: HTTPMethod.post, parameters: request.toJSON(), headers: self.headers, completion: completion)
    }

    // A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.
    public func vehicles(completion: @escaping (HTTPURLResponse, TKVehicleCollection?, Error?) -> Void) {
        self.httpClient.request(TeslaAPI.apiBaseURL.appendingPathComponent("vehicles"), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Get all data from vehicle
    public func data(for vehicle: TKVehicle, completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.httpClient.request(TKDataRequest.data.url(vehicleId: vehicle.id), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Get some data from the vehicle
    public func data<T: TKDataResponse>(for vehicle: TKVehicle, type: TKDataRequest, completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {
        self.httpClient.request(type.url(vehicleId: vehicle.id), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Send a command to the vehicle
    public func send(_ command: TKCommand, to vehicle: TKVehicle, request: TKMappable? = nil, completion: @escaping (TKCommandResponse) -> Void) {
        self.httpClient.request(command.url(vehicleId: vehicle.id), method: HTTPMethod.post, parameters: request?.toJSON(), encoding: JSONEncoding.default, headers: self.headers) { (httpResponse, dataOrNil: TKCommandResponse?, errorOrNil) in
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



    // MARK: - Convenience

    /// Attempt to wake the vehicle. Required for vehicle commands.
    ///
    /// - Parameters:
    ///   - context: TAContext
    ///   - completion: TKVehicleCommandCompletion
    public func wake(_ vehicle: TKVehicle, completion: @escaping (TKCommandResponse) -> Void) {
        var attempts: Int = 0
        var errorMessage: String?

        func doWake() {

            guard attempts < DefaultMaxAttempts else {
                completion(TKCommandResponse(result: false, reason: errorMessage ?? "An error occurred"))
                return
            }

            let requestDelay: TimeInterval = attempts == 0 ? 0 : DefaultRequestDelay

            DispatchQueue.main.asyncAfter(seconds: requestDelay) {

                self.send(.wake, to: vehicle) { response in

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
    public func wake(_ vehicle: TKVehicle, then command: TKCommand, completion: @escaping (TKCommandResponse) -> Void) {
        self.wake(vehicle) { response in
            if response.result && command != TKCommand.wake {
                self.send(command, to: vehicle, completion: completion)
            } else {
                completion(response)
            }
        }
    }
}


extension DispatchQueue {

    fileprivate func asyncAfter(seconds: Double, _ completion: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            completion()
        }
    }
}
