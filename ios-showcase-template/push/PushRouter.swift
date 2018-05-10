//
//  PushRouter.swift
//  ios-showcase-template
//
//  Created by Jan Hellar on 10.05.18.
//

import Foundation

protocol PushRouter {
    var viewController: PushViewController {get}
}

class PushRouterImpl: PushRouter {
    let viewController: PushViewController
    
    init(viewController: PushViewController) {
        self.viewController = viewController
    }
}
