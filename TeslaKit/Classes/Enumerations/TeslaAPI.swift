//
//  TeslaAPI.swift
//  TeslaApp
//
//  Created by Jaren Hamblin on 11/19/17.
//  Copyright © 2017 JJJJaren. All rights reserved.
//

import Foundation

///
public enum TeslaAPI: String, EnumCollection {

    /// Performs the login. Takes in an plain text email and password, matching the owner's login information for https://my.teslamotors.com/user/login. Returns a access_token which is passed along as a header with all future requests to authenticate the user.
    case accessToken = "oauth/token"

    // MARK: - Vehicles
    // A logged in user can have multiple vehicles under their account. This resource is primarily responsible for listing the vehicles and the basic details about them.

    /// Retrieve a list of your owned vehicles (includes vehicles not yet shipped!)
    case vehicles = "vehicles"

}
