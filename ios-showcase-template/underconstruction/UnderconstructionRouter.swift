//
//  UnderconstructionRouter.swift
//  ios-showcase-template

import Foundation

protocol UnderconstructionRouter {
    var viewController: UnderconstructionViewController { get }
}

class UnderconstructionRouterImpl: UnderconstructionRouter {
    let viewController: UnderconstructionViewController
    
    init(viewController: UnderconstructionViewController) {
        self.viewController = viewController
    }
}
