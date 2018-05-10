//
//  AccessControlRouter.swift
//  ios-showcase-template
//
//  Created by Wei Li on 02/01/2018.
//

import Foundation

protocol AccessControlRouter {
    var viewController: AccessControlViewController {get}
}

class AccessControlRouterImpl: AccessControlRouter {
    let viewController: AccessControlViewController
    
    init(viewController: AccessControlViewController) {
        self.viewController = viewController
    }
}
