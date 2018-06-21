//
//  LandingPagesRouter.swift
//  ios-showcase-template
//

import Foundation

protocol LandingPagesRouter {
    
    var viewController: LandingPagesViewController { get }
}

class LandingPagesRouterImpl: LandingPagesRouter {
    
    let viewController: LandingPagesViewController
    
    init(viewController: LandingPagesViewController) {
        self.viewController = viewController
    }

}
