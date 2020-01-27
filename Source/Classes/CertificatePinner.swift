//
//  CertificatePinner.swift
//  TeslaWatch WatchKit Extension
//
//  Created by Jaren Hamblin on 10/19/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation
import Security

class CertificatePinner: NSObject, URLSessionDelegate {

    let domains: [String: Bool]

    init(domains: [String: Bool]) {
        self.domains = domains
    }

    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {

        guard let serverTrust = challenge.protectionSpace.serverTrust,
            challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
        }

        guard domains.count > 0 else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }



        for (domain, pin) in domains {
            // Check if pinning is required
            guard pin else {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
                return
            }

            //Set policy to validate domain
            let policy = SecPolicyCreateSSL(true, domain as CFString)
            let policies = NSArray(object: policy)
            SecTrustSetPolicies(serverTrust, policies)

            let certificateCount = SecTrustGetCertificateCount(serverTrust)
            guard certificateCount > 0, let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                return
            }

            let serverCertificateData = SecCertificateCopyData(certificate) as Data
            let certificates = Certificate.localCertificates()
            for localCert in certificates {
                if localCert.validate(against: serverCertificateData, using: serverTrust) {
                    completionHandler(.useCredential, URLCredential(trust: serverTrust))
                    return // exit as soon as we found a match
                }
            }
        }

        // No valid cert available
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
