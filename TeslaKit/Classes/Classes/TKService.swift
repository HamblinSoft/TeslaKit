//
//  TKService.swift
//  Pods
//
//  Created by Jaren Hamblin on 1/10/18.
//

import Foundation
import Alamofire
import ObjectMapper

public protocol TKServiceDelegate: class {
    func activityDidBegin(_ service: TKService)
    func activityDidEnd(_ service: TKService)
}

public class TKService: Alamofire.SessionDelegate {

    ///
    public let configuration: URLSessionConfiguration

    public weak var delegate: TKServiceDelegate? = nil

    ///
    public private(set) lazy var sessionManager: Alamofire.SessionManager = self.getSessionManager()

    private func getSessionManager() -> Alamofire.SessionManager {
        return Alamofire.SessionManager(configuration: self.configuration, delegate: self, serverTrustPolicyManager: nil)
    }

    ///
    public init(timeout: TimeInterval = 30) {
        // Session Configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = timeout // seconds
        self.configuration = configuration
        super.init()
    }

    // MARK: - Helpers

    public func request<T: TKMappable>(_ url: URL,
                                       method: HTTPMethod,
                                       parameters: Parameters? = nil,
                                       encoding: ParameterEncoding = JSONEncoding.default,
                                       headers: HTTPHeaders? = nil,
                                       completion: @escaping (HTTPURLResponse, T?, Error?) -> Void) {

        delegate?.activityDidBegin(self)

        self.sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { dataResponse in
            let httpResponse: HTTPURLResponse = dataResponse.response ?? HTTPURLResponse(url: url, statusCode: 0, httpVersion: nil, headerFields: headers)!

            var mappedObjectOrNil: T? = nil

            if let data = dataResponse.data,
                let json = try? JSONSerialization.jsonObject(with: data),
                let object = Mapper<T>().map(JSONObject: json) {
                mappedObjectOrNil = object
            }

            let request = dataResponse.request ?? (try! URLRequest(url: url, method: method, headers: headers))
            self.debugPrint(request, response: httpResponse, responseData: dataResponse.data, error: dataResponse.error)

            self.delegate?.activityDidEnd(self)

            completion(httpResponse, mappedObjectOrNil, dataResponse.error)
        }
    }

    public func clearSession(completion: @escaping () -> Void) {
        let session = self.sessionManager.session
        session.invalidateAndCancel()
        session.reset {
            self.sessionManager = self.getSessionManager()
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
        if let data = request.httpBody, let json = try? JSON(data: data) {
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
        if let data = responseData, let json = try? JSON(data: data) {
            components.append("ResponseBody:\n\(json)")
        }

        components.insert("", at: 0)
        components.append("")
        let logMessage = components.joined(separator: "\n")
        print(logMessage)
    }
}
