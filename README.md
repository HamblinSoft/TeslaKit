# TeslaKit

[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg?style=flat)](https://github.com/Jarious-Apps/TeslaKit)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://github.com/CocoaPods/CocoaPods)
[![Version](https://img.shields.io/cocoapods/v/TeslaKit.svg?style=flat)](http://cocoapods.org/pods/TeslaKit)
[![License](https://img.shields.io/cocoapods/l/TeslaKit.svg?style=flat)](http://cocoapods.org/pods/TeslaKit)
[![Language](https://img.shields.io/badge/language-Swift%204-E05C43.svg?style=flat)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@JJJJaren-00ACED.svg?style=flat)](http://twitter.com/jjjjaren)


TeslaKit is a framework written in Swift that makes it easy for you to interface with Tesla's mobile API and communicate with your Tesla automobiles.

# Features
- [x] Authenticate with Tesla's API to obtain an access token
- [x] Retrieve a list of vehicles associated with your Tesla account
- [x] Obtain all data on your vehicle
- [x] Send commands to your vehicle
- [x] Utilizes `ObjectMapper` for `JSON` mapping
- [x] Uses `Structures` to maintain thread safe operations
- [x] VIN Decoder
- [ ] Summon and Homelink - Coming soon

# Installation

TeslaKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TeslaKit'
```

# Usage

Add an ATS exception domain for `owner-api.teslamotors.com` in your info.plist

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>owner-api.teslamotors.com</key>
        <dict>
            <key>NSIncludesSubdomains</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.0</string>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

Import `TeslaKit`
```swift
import TeslaKit
```

## TeslaAPI
Create a new `TeslaAPI` instance

```swift
let teslaAPI = TeslaAPI()
```

Also see initialization [configuration](#configuration)

## Access Token
Obtain an Access Token by logging in with your Tesla account credentials

```swift
let email = "e.musk@teslakit.com"
let password = "M@R$R0X!"

teslaAPI.accessToken(email: email, password: password) { (httpResponse, dataOrNil, errorOrNil) in

    guard let accessToken = dataOrNil?.accessToken else { return }

    // Set the accessToken for use with future requests
    teslaAPI.setAccessToken(accessToken)
}
```

## Vehicle List
Obtain a list of vehicles associated with your account

```swift
teslaAPI.vehicles { (httpResponse, dataOrNil, errorOrNil) in

    guard let vehicle = dataOrNil?.vehicles.first else { return }

    print("Hello, \(vehicle.displayName)")
}
```

## Vehicle Data
Obtain all data for a vehicle

```swift
teslaAPI.data(for: vehicle) { (httpResponse, dataOrNil, errorOrNil) in

    guard let vehicle = dataOrNil else { return }

    print("Battery is at \(vehicle.chargeState.batteryLevel)%")
}
```

## Send Command
Send a command to a vehicle

```swift
let command = TKCommand.unlockDoors

teslaAPI.send(command, to: vehicle) { response in
    if response.result {
        print("Command sent successfully!")
    }
}
```

Send a command to a vehicle with request parameters

```swift
let parameters = TKSetTemperature(driverTemp: 21.0, passengerTemp: 21.0)

teslaAPI.send(.setTemperature, to: vehicle, parameters: parameters) { response in
    if response.result {
        print("Command sent successfully!")
    }
}
```

# <a name="configuration"></a>Configuration

## Default
```swift
let teslaAPI = TeslaAPI(configuration: .default) // same as TeslaAPI()
```

The ```default``` configuration points to Tesla's production owner API

## Mock
```swift
let teslaAPI = TeslaAPI(configuration: .mock)
```

The ```mock``` configuration directs all requests to a custom server that returns a predefined responses for each of the owner API endpoints allowing you to work with some real-looking data to work with without having to own a Tesla vehicle or without having a Tesla account at all.

Note: Because this is a free service, requests are occasionally throttled.

## Custom
```swift
let customConfig = TeslaAPI.Configuration(baseURL: URL(string: "SOME_URL")!,
                                          clientId: "SOME_CLIENT_ID",
                                          clientSecret: "SOME_CLIENT_SECRET",
                                          requestTimeout: 30)

let teslaAPI = TeslaAPI(configuration: customConfig)
```

The ```custom``` configuration allows you to specify your own ```baseURL```. This is convenient if you would like to point to your own environment. You can also specify an alternate ```clientId``` and ```clientSecret``` value. You can also specify a different request timeout interval (default: ```30```)

## Debug Mode

```swift
let teslaAPI = TeslaAPI(debugMode: true)
```

Enabling debug mode will print all the raw request and response information to the console (default: ```false```)

# VIN Decoder

```swift
let vin = VIN(vinString: "5YJSA1E2XHF999999")!
print(vin.make)         // Model S
print(vin.driveUnit)    // Dual Motor
print(vin.modelYear)    // TeslaKit.VINComponent.ModelYear.year2017
print(vin.serialNo)     // 999999
print(vin.vinString)    // 5YJSA1E2XHF999999
```

# Author

jjjjaren, jjjjaren@gmail.com

# License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

> This project is in no way affiliated with Tesla Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs.
