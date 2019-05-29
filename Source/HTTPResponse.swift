//
//  HTTPResponse.swift
//  TeslaKit
//
//  Created by Jaren Hamblin on 3/29/19.
//

import Foundation

///
public class HTTPResponse<T: JSONDecodable> {

    ///
    public let httpResponse: HTTPURLResponse

    ///
    public let data: T?

    ///
    public let rawData: Data?

    ///
    public let error: Error?

    ///
    public init(httpResponse: HTTPURLResponse, data: T?, rawData: Data?, error: Error?) {
        self.httpResponse = httpResponse
        self.data = data
        self.rawData = rawData
        self.error = error
    }

    ///
    public var statusCode: Int { return httpResponse.statusCode }

    ///
    public var localizedStatusCodeDescription: String { return HTTPURLResponse.localizedString(forStatusCode: statusCode) }
}
