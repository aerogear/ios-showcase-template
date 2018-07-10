import Foundation

import Alamofire
import SwiftyJSON

extension Notification.Name {
    static let invalidCertificateFound = Notification.Name("invalidCertificateFound")
}

struct CertificateCheckResult {
    var error: Error?
}

class CertificateHelper {
    private static let certificateErrors = [NSURLErrorSecureConnectionFailed,
                             NSURLErrorServerCertificateHasBadDate,
                             NSURLErrorServerCertificateUntrusted,
                             NSURLErrorServerCertificateHasUnknownRoot,
                             NSURLErrorServerCertificateNotYetValid,
                             NSURLErrorClientCertificateRejected,
                             NSURLErrorClientCertificateRequired]
    
    /// Perform a check on the first service available in a mobile configuration file.
    ///
    /// - Parameter serviceConfig: The contents of a mobile configuration file.
    class func checkCertificates(_ serviceConfig: JSON) {
        let serviceList = serviceConfig["services"]
        
        if serviceList.isEmpty {
            return
        }
        guard let serviceURLToCheck = CertificateHelper.findServiceWithURL(serviceList.arrayValue) else {
            return
        }

        Alamofire.request(serviceURLToCheck).response { (response) in
            if let responseError = (response.error as NSError?) {
                // Ensure that the error that is returned is actually an SSL error, we don't want to show the dialog if it's not.
                if certificateErrors.contains(where: { errorCode in
                    return responseError.code == errorCode
                }) {
                    NotificationCenter.default.post(name: .invalidCertificateFound, object: responseError)
                    return
                }
                Logger.error("Certificate check request failed for non-invalid certficate reasons. Details: \(responseError)")
            }
        }
    }
    
    /// Retrieve the first service in a list of mobile service configurations that contains a URL field.
    ///
    /// - Parameter services: A list of mobile service configurations.
    /// - Returns: The URL of the first service which contains a URL.
    private class func findServiceWithURL(_ services: [JSON]) -> String? {
        let foundService = services.first { (service) -> Bool in
            return service["url"].exists()
        }
        return foundService?["url"].stringValue
    }
}
