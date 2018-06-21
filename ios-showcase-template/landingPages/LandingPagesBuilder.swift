//
//  LandingPagesBuilder.swift
//  ios-showcase-template
//

import Foundation

class LandingPagesBuilder {
    func build() -> LandingPagesRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingPageViewController") as! LandingPagesViewController
        
        let landingPagesRouter = LandingPagesRouterImpl(viewController: viewController)
        return landingPagesRouter
    }
}
