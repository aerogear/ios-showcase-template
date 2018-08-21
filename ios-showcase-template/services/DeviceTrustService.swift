import AGSSecurity
import DTTJailbreakDetection
import Foundation
import LocalAuthentication

protocol DeviceTrustService {
    func performTrustChecks() -> [SecurityCheckResult]
}

class iosDeviceTrustService: DeviceTrustService {
    var security: AgsSecurity
    var detections: [SecurityCheckResult]

    /**
     - Initilise the iOS Device Trust Service
    */
    init() {
        self.detections = []
        self.security = AgsSecurity()
    }

    /**
     - Perform the Device Trust Checks

     - Returns: A list of SecurityCheckResult objects
     */
    func performTrustChecks() -> [SecurityCheckResult] {
        self.detections = []
        if #available(iOS 9.0, *) {
            self.detections.append(detectDeviceLock())
        }
        self.detections.append(detectJailbreak())
        self.detections.append(detectEmulator())
        self.detections.append(detectDebugabble())

        return self.detections
        
    }

    // tag::detectAll[]
    /**
     - Perform all security checks and publish the results
     
     - Returns: A SecurityCheckResult array
     */
    fileprivate func detectAll() -> [SecurityCheckResult] {
        let checks : [SecurityCheck] = [DeviceLockCheck(), NonDebugCheck(), NonEmulatorCheck(), NonJailbrokenCheck()]
        return self.security.checkManyAndPublishMetric(checks)
    }
    
    // tag::detectDeviceLock[]
    /**
     - Check if a lock screen is set on the device. (iOS 9 or higher).

     - Returns: A SecurityCheckResult object.
     */
    fileprivate func detectDeviceLock() -> SecurityCheckResult {
        return self.security.checkAndPublishMetric(DeviceLockCheck())
    }
    // end::detectDeviceLock[]

    // tag::detectJailbreak[]
    /**
     - Check if the device running the application is jailbroken.

     - Returns: A SecurityCheckResult object.
     */

    fileprivate func detectJailbreak() -> SecurityCheckResult {
        return self.security.checkAndPublishMetric(NonJailbrokenCheck())
    }

    // end::detectJailbreak[]

    // tag::detectDebugabble[]
    /**
     - Check if the device running the application is jailbroken.

     - Returns: A SecurityCheckResult object.
     */
    fileprivate func detectDebugabble() -> SecurityCheckResult {
        return self.security.checkAndPublishMetric(NonDebugCheck())
    }

    // end::detectDebugabble[]

    // tag::detectEmulator[]
    /**
     - Check if the application is running in an emulator.

     - Returns: A SecurityCheckResult object.
     */
    fileprivate func detectEmulator() -> SecurityCheckResult {
        return self.security.checkAndPublishMetric(NonEmulatorCheck())
    }

    // end::detectEmulator[]
}
