# TeslaKit 📱 ⌚

[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg?style=flat)](https://github.com/Jarious-Apps/TeslaKit)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://github.com/CocoaPods/CocoaPods)
[![Version](https://img.shields.io/cocoapods/v/TeslaKit.svg?style=flat)](http://cocoapods.org/pods/TeslaKit)
[![License](https://img.shields.io/cocoapods/l/TeslaKit.svg?style=flat)](http://cocoapods.org/pods/TeslaKit)
[![Language](https://img.shields.io/badge/language-Swift%204-E05C43.svg?style=flat)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@JJJJaren-00ACED.svg?style=flat)](http://twitter.com/jjjjaren)

## Compatibility
This is a universal framework that works with
- iOS
- watchOS

## Dependencies

- ObjectMapper

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

TeslaKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TeslaKit'
```

## Usage

Add an ATS exception domain for `owner-api.teslamotors.com`

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

Import the `TeslaKit` library
```swift
import TeslaKit
```

Create a new `TeslaAPI` instance
```swift
let teslaAPI = TeslaAPI(ownerApiClientId: "CLIENT_ID",
                        ownerApiClientSecret: "CLIENT_SECRET")
```

Obtain an Access Token by logging in with your Tesla account credentials

```swift
teslaAPI.accessToken(email: "elon.musk@teslakit.com", password: "M@R$R0CKZ!") { (httpResponse, dataOrNil, errorOrNil) in

    guard let accessToken: String = dataOrNil?.accessToken else { return }

    // Set the accessToken for use with future requests
    teslaAPI.setAccessToken(accessToken)
}
```


Obtain a list of vehicles associated with your account

```swift
teslaAPI.vehicles { (httpResponse, dataOrNil, errorOrNil) in

    guard let vehicles: [TKVehicle] = dataOrNil?.vehicles else { return }

    let vehicle: TKVehicle? = vehicles.first
}
```

Obtain vehicle data

```swift
teslaAPI.data(for: vehicle) { (httpResponse, dataOrNil, errorOrNil) in

    guard let vehicle = dataOrNil else { return }

    print(vehicle.displayName, vehicle.chargeState.batteryLevel)
}
```

Send a command

```swift
let command: TKCommand = TKCommand.unlockDoors

teslaAPI.send(command, to: vehicle) { response in
    guard response.result else {
        print(response.allErrorMessages)
        return
    }
    print("Command issued successfully!")
}
```

## Author

jjjjaren, jjjjaren@gmail.com

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

> This project is in no way affiliated with Tesla Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs.
