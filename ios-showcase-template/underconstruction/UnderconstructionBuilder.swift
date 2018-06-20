//
//  UnderconstructionBuilder.swift
//  ios-showcase-template

import Foundation

class UnderconstructionBuilder {
    func build() -> UnderconstructionRouter {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "UnderconstructionViewController") as! UnderconstructionViewController
        
        let underconstructionRouter = UnderconstructionRouterImpl(viewController: viewController)
        return underconstructionRouter
    }
}
