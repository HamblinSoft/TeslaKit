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

    // TODO: Consider moving this into a context
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
        self.service.request(TeslaAPI.apiBaseURL.appendingPathComponent("vehicles"), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Get all data from vehicle
    public static func data(for vehicle: TKVehicle, completion: @escaping (HTTPURLResponse, TKVehicle?, Error?) -> Void) {
        self.service.request(TKDataRequest.data.url(vehicleId: vehicle.id), method: HTTPMethod.get, headers: self.headers, mapContext: TKMapContext(vehicleDataMapping: true), completion: completion)
    }

    /// Get some data from the vehicle
    public static func data<T: TKDataResponse>(for vehicle: TKVehicle, type: TKDataRequest, completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {
        self.service.request(type.url(vehicleId: vehicle.id), method: HTTPMethod.get, headers: self.headers, completion: completion)
    }

    /// Send a command to the vehicle
    public static func send(_ command: TKCommand, to vehicle: TKVehicle, request: TKMappable? = nil, completion: @escaping (TKVehicleCommandResponse) -> Void) {
        self.service.request(command.url(vehicleId: vehicle.id), method: HTTPMethod.post, headers: self.headers) { (httpResponse, dataOrNil: TKVehicleCommandResponse?, errorOrNil) in
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
    public static func wake(_ vehicle: TKVehicle, completion: @escaping (TKVehicleCommandResponse) -> Void) {
        var attempts: Int = 0
        var errorMessage: String?

        func doWake() {

            guard attempts < DefaultMaxAttempts else {
                completion(TKVehicleCommandResponse(result: false, reason: errorMessage ?? "An error occurred"))
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
    public static func wake(_ vehicle: TKVehicle, then command: TKCommand, completion: @escaping (TKVehicleCommandResponse) -> Void) {
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
