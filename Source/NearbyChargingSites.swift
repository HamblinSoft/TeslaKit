//
//  NearbyChargingSites.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 10/14/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation

///
public final class NearbyChargingSites: JSONDecodable {

    ///
    public final class LocationCoordinate: JSONDecodable {

        ///
        public let latitude: Double

        ///
        public let longitude: Double

        ///
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }

        ///
        public init(from decoder: Decoder) throws {
            self.latitude = try decoder.decodeIfPresent(CodingKeys.latitude) ?? 0
            self.longitude = try decoder.decodeIfPresent(CodingKeys.longitude) ?? 0
        }

        ///
        private enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "long"
        }
    }

    ///
    public final class DestinationCharger: JSONDecodable {

        ///
        public let name: String

        ///
        public let type: String

        ///
        public let distanceMiles: Double

        ///
        public let location: LocationCoordinate

        ///
        public init(name: String, type: String, distanceMiles: Double, location: LocationCoordinate) {
            self.name = name
            self.type = type
            self.distanceMiles = distanceMiles
            self.location = location
        }

        ///
        public init(from decoder: Decoder) throws {
            self.name = try decoder.decodeIfPresent(CodingKeys.name) ?? ""
            self.type = try decoder.decodeIfPresent(CodingKeys.type) ?? ""
            self.distanceMiles = try decoder.decodeIfPresent(CodingKeys.distanceMiles) ?? 0
            self.location = try decoder.decodeIfPresent(CodingKeys.location) ?? LocationCoordinate(latitude: 0, longitude: 0)
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case type
            case distanceMiles = "distance_miles"
            case location
        }
    }

    ///
    public final class Supercharger: JSONDecodable {

        ///
        public let name: String

        ///
        public let type: String

        ///
        public let distanceMiles: Double

        ///
        public let availableStalls: Int

        ///
        public let totalStalls: Int

        ///
        public let siteClosed: Bool

        ///
        public let location: LocationCoordinate

        ///
        public init(name: String, type: String, distanceMiles: Double, availableStalls: Int, totalStalls: Int, siteClosed: Bool, location: LocationCoordinate) {
            self.name = name
            self.type = type
            self.distanceMiles = distanceMiles
            self.availableStalls = availableStalls
            self.totalStalls = totalStalls
            self.siteClosed = siteClosed
            self.location = location
        }

        ///
        public init(from decoder: Decoder) throws {
            self.name = try decoder.decodeIfPresent(CodingKeys.name) ?? ""
            self.type = try decoder.decodeIfPresent(CodingKeys.type) ?? ""
            self.distanceMiles = try decoder.decodeIfPresent(CodingKeys.distanceMiles) ?? 0
            self.availableStalls = try decoder.decodeIfPresent(CodingKeys.availableStalls) ?? 0
            self.totalStalls = try decoder.decodeIfPresent(CodingKeys.totalStalls) ?? 0
            self.siteClosed = try decoder.decodeIfPresent(CodingKeys.siteClosed) ?? false
            self.location = try decoder.decodeIfPresent(CodingKeys.location) ?? LocationCoordinate(latitude: 0, longitude: 0)
        }

        private enum CodingKeys: String, CodingKey {
            case name
            case type
            case distanceMiles = "distance_miles"
            case availableStalls = "available_stalls"
            case totalStalls = "total_stalls"
            case siteClosed = "site_closed"
            case location
        }
    }

    ///
    public let congestionSyncTimeUtcSecs: TimeInterval

    ///
    public let destinationCharging: [DestinationCharger]

    ///
    public let superchargers: [Supercharger]

    ///
    public let timestamp: TimeInterval

    ///
    public init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try responseContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        self.congestionSyncTimeUtcSecs = try container.decodeIfPresent(TimeInterval.self, forKey: .congestionSyncTimeUtcSecs) ?? 0
        self.destinationCharging = try container.decodeIfPresent([DestinationCharger].self, forKey: .destinationCharging) ?? []
        self.superchargers = try container.decodeIfPresent([Supercharger].self, forKey: .superchargers) ?? []
        self.timestamp = try container.decodeIfPresent(TimeInterval.self, forKey: .timestamp) ?? 0
    }

    private enum CodingKeys: String, CodingKey {
        case response
        case congestionSyncTimeUtcSecs = "congestion_sync_time_utc_secs"
        case destinationCharging = "destination_charging"
        case superchargers
        case timestamp
    }
}

//{
//  "response":{
//    "congestion_sync_time_utc_secs":1545091987,
//    "destination_charging":[
//      {
//        "location":{
//          "lat":33.811484,
//          "long":-118.138451
//        },
//        "name":"Long Beach Marriott",
//        "type":"destination",
//        "distance_miles":2.201606
//      },
//      {
//        "location":{
//          "lat":33.767198,
//          "long":-118.191987
//        },
//        "name":"Renaissance Long Beach Hotel",
//        "type":"destination",
//        "distance_miles":4.071068
//      },
//      {
//        "location":{
//          "lat":33.757146,
//          "long":-118.19861
//        },
//        "name":"Hotel Maya, a Doubletree by Hilton",
//        "type":"destination",
//        "distance_miles":4.843953
//      },
//      {
//        "location":{
//          "lat":33.832254,
//          "long":-118.079218
//        },
//        "name":"The Gardens Casino",
//        "type":"destination",
//        "distance_miles":6.449794
//      }
//    ],
//    "superchargers":[
//      {
//        "location":{
//          "lat":33.934471,
//          "long":-118.121217
//        },
//        "name":"Downey, CA - Stonewood Street",
//        "type":"supercharger",
//        "distance_miles":2.196721,
//        "available_stalls":5,
//        "total_stalls":12,
//        "site_closed":false
//      },
//      {
//        "location":{
//          "lat":33.953385,
//          "long":-118.112905
//        },
//        "name":"Downey, CA - Lakewood Boulevard",
//        "type":"supercharger",
//        "distance_miles":9.587273,
//        "available_stalls":6,
//        "total_stalls":12,
//        "site_closed":false
//      },
//      {
//        "location":{
//          "lat":33.921063,
//          "long":-118.330074
//        },
//        "name":"Hawthorne, CA",
//        "type":"supercharger",
//        "distance_miles":12.197322,
//        "available_stalls":3,
//        "total_stalls":6,
//        "site_closed":false
//      },
//      {
//        "location":{
//          "lat":33.894227,
//          "long":-118.367407
//        },
//        "name":"Redondo Beach, CA",
//        "type":"supercharger",
//        "distance_miles":13.125912,
//        "available_stalls":3,
//        "total_stalls":8,
//        "site_closed":false
//      }
//    ],
//    "timestamp":1545092157769
//  }
//}
