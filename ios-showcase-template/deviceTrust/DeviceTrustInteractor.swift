//
//  DeviceTrustInteractor.swift
//  ios-showcase-template
//
//  Created by Tom Jackman on 30/11/2017.
//

import Foundation
import AGSSec

/* Implement the business logic for the device trust view here. */
protocol DeviceTrustInteractor: DeviceTrustListener {
    var deviceTrustService: DeviceTrustService { get }
    var router: DeviceTrustRouter? { get set }
}

class DeviceTrustInteractorImpl: DeviceTrustInteractor {
  
    var deviceTrustService: DeviceTrustService
    var router: DeviceTrustRouter?

    init(deviceTrustService: DeviceTrustService) {
        self.deviceTrustService = deviceTrustService
    }

    /**
     - Perform the device trust checks in the device trust service.

     - Returns Detector: A list of detection results
     */
    func performTrustChecks() -> [SecurityCheckResult] {
        return self.deviceTrustService.performTrustChecks()
    }
}
