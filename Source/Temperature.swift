//
//  Temperature.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 12/19/17.
//

import Foundation

/// An object representing a temperature unit
public struct Temperature: CustomStringConvertible {

    ///
    public static let Degree: String = "°"

    /// Returns the temperature in degrees Celsius
    public let celsius: Double

    /// Returns the temperature in degrees Fahrenheit
    public let fahrenheit: Double

    /// Initializes a `Temperature` object with degrees Celsius as the starting reference point
    public init(celsius: Double) {
        self.celsius = celsius
        self.fahrenheit = Temperature.convert(celsiusToFahrenheit: celsius)
    }

    /// Initializes a `Temperature` object with degrees Fahrenheit as the starting reference point
    public init(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
        self.celsius = Temperature.convert(fahrenheitToCelsius: fahrenheit)
    }


    /// Returns the value of a degree in Celsius in Fahrenheit. 20C = 68F
    ///
    /// - Parameter value: Degrees in Celsius
    /// - Returns: Degrees in Fahrenheit
    public static func convert(celsiusToFahrenheit value: Double) -> Double {
        return value * 9/5 + 32
    }


    /// Returns the value of a degree in Fahrenheit in Celsius. 20F = -6.67F
    ///
    /// - Parameter value: Degrees in Fahrenheit
    /// - Returns: Degrees in Celsius
    public static func convert(fahrenheitToCelsius value: Double) -> Double {
        return (value - 32) * 5/9
    }

    ///
    public var localizedCelsius: String { return String(format: "%.1f", self.celsius) + Temperature.Degree }

    ///
    public var localizedFahrenheit: String { return String(format: "%.f", self.fahrenheit) + Temperature.Degree }

    ///
    public func format(isFahrenheit: Bool) -> String {
        return isFahrenheit ? self.localizedFahrenheit : self.localizedCelsius
    }

    ///
    public var description: String {
        return self.localizedCelsius + "  " + localizedFahrenheit
    }
}
