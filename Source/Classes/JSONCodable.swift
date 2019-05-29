//
//  JSONCodable.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 5/28/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

///
public protocol JSONEncodable: Encodable {}

///
public protocol JSONDecodable: Decodable {}

///
public protocol JSONCodable: JSONEncodable, JSONDecodable {}

///
extension JSONEncodable {

    ///
    public func encoded(_ coder: JSONEncoder = JSONEncoder()) -> Data {
        return (try? coder.encode(self)) ?? Data()
    }

    ///
    public func toJSONData() -> Data {
        return encoded()
    }

    ///
    public func toJSON(options: JSONSerialization.ReadingOptions = []) -> Any {
        return (try? JSONSerialization.jsonObject(with: encoded(), options: options)) as Any
    }

    ///
    public func toJSONString(encoding: String.Encoding = .utf8) -> String {
        return String(data: encoded(), encoding: encoding) ?? ""
    }
}

///
extension JSONDecoder {

    ///
    public func decode<T: JSONCodable>(_ data: Data) -> T? {
        return try? decode(T.self, from: data)
    }
}
