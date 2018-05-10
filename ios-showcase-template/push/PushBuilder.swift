//
//  PushBuilder.swift
//  ios-showcase-template
//
//  Created by Jan Hellar on 10.05.18.
//

import Foundation

class PushBuilder {
    
    func build() -> PushRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "PushViewController") as! PushViewController
        
        let pushRouter = PushRouterImpl(viewController: viewController)
        return pushRouter
    }
}
