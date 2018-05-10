//
//  DeviceTrustRouter.swift
//  ios-showcase-template
//
//  Created by Tom Jackman on 30/11/2017.
//

import Foundation

/* Manage the routing insdie the device trust view */
protocol DeviceTrustRouter {
    var viewController: DeviceTrustViewController {get}
}

class DeviceTrustRouterImpl: DeviceTrustRouter {
    let viewController: DeviceTrustViewController
    
    init(viewController: DeviceTrustViewController) {
        self.viewController = viewController
    }
    
}
