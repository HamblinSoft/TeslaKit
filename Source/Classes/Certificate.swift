//
//  Certificate.swift
//  TeslaWatch WatchKit Extension
//
//  Created by Jaren Hamblin on 10/18/19.
//  Copyright © 2019 HamblinSoft. All rights reserved.
//

import Foundation
import Security

struct Certificate {
    let certificate: SecCertificate
    let data: Data
}

extension Certificate {
    static func localCertificates(with names: [String] = ["CertificateRenewed", "Certificate"],
                                  from bundle: Bundle = .main) -> [Certificate] {
        return names.lazy.map({
            guard let file = bundle.url(forResource: $0, withExtension: "cer"),
                let data = try? Data(contentsOf: file),
                let cert = SecCertificateCreateWithData(nil, data as CFData) else {
                    return nil
            }
            return Certificate(certificate: cert, data: data)
        }).compactMap{$0}
    }

    func validate(against certData: Data, using secTrust: SecTrust) -> Bool {
        let certArray = [certificate] as CFArray
        SecTrustSetAnchorCertificates(secTrust, certArray)

        //validates a certificate by verifying its signature plus the signatures of
        // the certificates in its certificate chain, up to the anchor certificate
        var result = SecTrustResultType.invalid
        SecTrustEvaluate(secTrust, &result)
        let isValid = (result == .unspecified || result == .proceed)

        //Validate host certificate against pinned certificate.
        return isValid && certData == self.data
    }
}
