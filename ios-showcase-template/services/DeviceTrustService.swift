import AGSSecurity
import DTTJailbreakDetection
import Foundation
import LocalAuthentication

protocol DeviceTrustService {
    func performTrustChecks() -> [DeviceCheckResult]
}

class iosDeviceTrustService: DeviceTrustService {
    var security: AgsSecurity
    var detections: [DeviceCheckResult]

    /**
     - Initilise the iOS Device Trust Service
    */
    init() {
        self.detections = []
        self.security = AgsSecurity()
    }

    /**
     - Perform the Device Trust Checks

     - Returns: A list of DeviceCheckResult objects
     */
    func performTrustChecks() -> [DeviceCheckResult] {
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
     
     - Returns: A DeviceCheckResult array
     */
    fileprivate func detectAll() -> [DeviceCheckResult] {
        let checks : [DeviceCheck] = [DeviceLockEnabledCheck(), DebuggerAttachedCheck(), IsEmulatorCheck(), JailbrokenDeviceCheck()]
        return self.security.checkManyAndPublishMetric(checks)
    }
    
    // tag::detectDeviceLock[]
    /**
     - Check if a lock screen is set on the device. (iOS 9 or higher).

     - Returns: A DeviceCheckResult object.
     */
    fileprivate func detectDeviceLock() -> DeviceCheckResult {
        return self.security.checkAndPublishMetric(DeviceLockEnabledCheck())
    }
    // end::detectDeviceLock[]

    // tag::detectJailbreak[]
    /**
     - Check if the device running the application is jailbroken.

     - Returns: A DeviceCheckResult object.
     */

    fileprivate func detectJailbreak() -> DeviceCheckResult {
        return self.security.checkAndPublishMetric(JailbrokenDeviceCheck())
    }

    // end::detectJailbreak[]

    // tag::detectDebugabble[]
    /**
     - Check if the device running the application is jailbroken.

     - Returns: A DeviceCheckResult object.
     */
    fileprivate func detectDebugabble() -> DeviceCheckResult {
        return self.security.checkAndPublishMetric(DebuggerAttachedCheck())
    }

    // end::detectDebugabble[]

    // tag::detectEmulator[]
    /**
     - Check if the application is running in an emulator.

     - Returns: A DeviceCheckResult object.
     */
    fileprivate func detectEmulator() -> DeviceCheckResult {
        return self.security.checkAndPublishMetric(IsEmulatorCheck())
    }

    // end::detectEmulator[]
}
